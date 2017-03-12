//
//  Calculator.swift
//  CS193p-calculator
//
//  Created by Constantine Shatalov on 11/6/16.
//  Copyright © 2016 New Route. All rights reserved.
//

import Foundation

class Calculator {
    
    private var accumulator = 0.0
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(_ operand: Double) {
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
    private var operations: [String: Operation] = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×": Operation.BinaryOperation(*),
        "÷": Operation.BinaryOperation(/),
        "+": Operation.BinaryOperation(+),
        "−": Operation.BinaryOperation(-),
        "=": Operation.Equals
    ]
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
        
        internalProgram.append(symbol as AnyObject)
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    // Calculator Memory
    typealias PropertyList = AnyObject
    
    private var internalProgram = [AnyObject]()
    
    var program: PropertyList {
        get {
            return internalProgram as Calculator.PropertyList
        }
        
        set {
            clear()
            if let ops = newValue as? [AnyObject] {
                for op in ops {
                    if let operand = op as? Double {
                        setOperand(operand)
                    } else if let operand = op as? String {
                        performOperation(operand)
                    }
                }
            }
        }
    }
    
    func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
}
