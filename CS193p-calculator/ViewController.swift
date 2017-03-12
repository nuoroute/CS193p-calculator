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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private var userIsTyping = false
    
    private var calculator = Calculator()
    
    @IBOutlet private weak var display: UILabel!
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let textCurrentlyOnDisplay = display.text!
            display.text = textCurrentlyOnDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsTyping {
            calculator.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let symbol = sender.currentTitle {
            calculator.performOperation(symbol)
        }
        
        displayValue = calculator.result
    }
    
    // Calculator Memory
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
    
}
