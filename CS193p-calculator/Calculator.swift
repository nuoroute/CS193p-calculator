//
//  Calculator.swift
//  CS193p-calculator
//
//  Created by Constantine Shatalov on 11/6/16.
//  Copyright © 2016 New Route. All rights reserved.
//

import Foundation

class Calculator {
    
    typealias PropertyList = AnyObject

    private var accumulator = 0.0
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
                        setOperand(operand: operand)
                    } else if let operand = op as? String {
                        performOperation(symbol: operand)
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
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
    private var operations: [String: Operation] = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×": Operation.BinaryOperation(*), // might have to be ({$0 * $1})
        "÷": Operation.BinaryOperation(/),
        "+": Operation.BinaryOperation(+),
        "−": Operation.BinaryOperation(-),
        "=": Operation.Equals
    ]
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func performOperation(symbol: String) {
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
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
