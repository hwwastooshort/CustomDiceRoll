//
//  DnDNotationTest.swift
//  CustomDiceRollTests
//
//  Created by Harvey Wirth on 04.01.25.
//
import XCTest
@testable import CustomDiceRoll

final class DnDNotationTest: XCTestCase {
    
    func testDiceRollWithZeroDicesOrZeroRolls() {
        do {
            let result1 = try DiceNotationParser.parseAndEvaluate("0d0")
            XCTAssertEqual(result1, 0, "Rolling 0d0 should result in 0.")
            let result2 = try DiceNotationParser.parseAndEvaluate("3d0")
            XCTAssertEqual(result2, 0, "Rolling 3d0 should return 0")
        } catch {
            XCTFail("Parsing or evaluating '0d0' should not throw an error: \(error)")
        }
    }
    
    func testDiceRollWithoutParantheses() {
        do {
            for i in 1...100 {
                let result = try DiceNotationParser.parseAndEvaluate("1d\(i)")
                let isInRange = result >= 1 && result <= i
                XCTAssertTrue(isInRange, "The Roll 1d\(i) should be between 1 and \(i)")
            }
        } catch {
            XCTFail("Normal Dice Rolls should work without any Problems: \(error)")
        }
    }
    
    func testDiceRollWithConstants() {
        do {
            let result = try DiceNotationParser.parseAndEvaluate("3d6 + 2")
            let isInRange = result >= 5 && result <= 20
            XCTAssertTrue(isInRange, "The Roll 3d6 + 2 should be between 5 and 20")
        } catch {
            XCTFail("Dice Rolls with Constants should work without any Problems: \(error) ")
        }
    }
    
    func testDiceRollWithConstantsAndParantheses() {
        do {
            let result = try DiceNotationParser.parseAndEvaluate("4d6 + ((3 + 1) * 2)")
            // equal to 4d6 + 8
            let isInRange = result >= 8 && result <= 32
            XCTAssertTrue(isInRange)
        } catch {
            XCTFail("Die Rolls with Constants and Parantheses should work without any Issues: \(error)")
        }
    }
    
    func testDivisionByZeroThrowsError() {
        let input = "10 / 0"
        XCTAssertThrowsError(try DiceNotationParser.parseAndEvaluate(input)) { error in
            guard let nsError = error as NSError? else {
                XCTFail("Error is not an NSError")
                return
            }
            XCTAssertEqual(nsError.domain, "DivisionByZero", "Unexpected error domain")
            XCTAssertEqual(nsError.code, 1, "Unexpected error code")
            XCTAssertEqual(nsError.userInfo[NSLocalizedDescriptionKey] as? String, "Division by zero is not allowed", "Unexpected error message")
        }
    }
}
