//
//  CalculatorTests.swift
//  CS193p-calculator
//
//  Created by Constantine Shatalov on 3/12/17.
//  Copyright © 2017 New Route. All rights reserved.
//

import XCTest
@testable import CS193p_calculator

class CalculatorTests: XCTestCase {
    
    let calculator = Calculator()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Tests: 
    // • Unary operation (doubled)
    // • Binary operation (doubled)
    
    func testUnaryOperation() {
        // First operation
        calculator.setOperand(81)
        calculator.performOperation("√")
        
        // Second operation
        calculator.performOperation("√")
        
        XCTAssertEqual(calculator.result, 3)
    }
    
    func testBinaryOperation() {
        // First operation
        calculator.setOperand(81)
        calculator.performOperation("/")
        calculator.setOperand(9)
        calculator.performOperation("=")
        
        // Second operation
        calculator.performOperation("/")
        calculator.setOperand(3)
        calculator.performOperation("=")
        
        XCTAssertEqual(calculator.result, 3)
    }
    
}
