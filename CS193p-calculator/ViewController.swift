//
//  ViewController.swift
//  CS193p-calculator
//
//  Created by Constantine Shatalov on 11/5/16.
//  Copyright © 2016 New Route. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private var calculator = Calculator()
    
    private var userIsInTheMiddleOfTyping = false
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    // Outlets:
    @IBOutlet private weak var display: UILabel!
    
    // Calculator Memory:
    var savedProgram: Calculator.PropertyList?
    
    @IBAction func save() {
        savedProgram = calculator.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            calculator.program = savedProgram!
            displayValue = calculator.result
        }
    }
    
    // Actions:
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyOnDisplay = display.text!
            display.text = textCurrentlyOnDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            calculator.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculator.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue = calculator.result
    }
}


















