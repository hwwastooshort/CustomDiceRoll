//
//  DiceNotationParser.swift
//  CustomDiceRoll
//
//  Created by Harvey Wirth on 04.01.25.
//  Regex was made by ChatGPT, used ChatGPT for Stringsplitting
//  and bugfixing
//

import Foundation

struct DiceNotationParser {
    static func parseAndEvaluate(_ input: String) throws -> Int {
        let tokens = try tokenize(input)
        return try evaluate(tokens)
    }
    
    private enum Token {
        case number(Int)
        case dice(Int, Int)
        case operatorSymbol(Character)
        case parenthesisOpen
        case parenthesisClose
    }

    private static func tokenize(_ input: String) throws -> [Token] {
        let pattern = #"""
        (\d+d\d+|\d+|[+\-*/()]|\s+)
        """#
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        var tokens: [Token] = []

        for match in matches {
            let token = String(input[Range(match.range, in: input)!]).trimmingCharacters(in: .whitespaces)
            
            if token.isEmpty { continue }
            
            if let diceMatch = token.range(of: #"^\d+d\d+$"#, options: .regularExpression) {
                let components = token[diceMatch].split(separator: "d").map { Int($0)! }
                tokens.append(.dice(components[0], components[1]))
            } else if let number = Int(token) {
                tokens.append(.number(number))
            } else if "+-*/".contains(token) {
                tokens.append(.operatorSymbol(token.first!))
            } else if token == "(" {
                tokens.append(.parenthesisOpen)
            } else if token == ")" {
                tokens.append(.parenthesisClose)
            } else {
                throw NSError(domain: "InvalidTokenError", code: 1, userInfo: nil)
            }
        }
        return tokens
    }

    private static func evaluate(_ tokens: [Token]) throws -> Int {
        var tokens = tokens
        return try parseExpression(&tokens)
    }

    private static func parseExpression(_ tokens: inout [Token]) throws -> Int {
        var value = try parseTerm(&tokens)
        while let token = tokens.first, case let .operatorSymbol(op) = token, "+-".contains(op) {
            tokens.removeFirst()
            let rhs = try parseTerm(&tokens)
            value = op == "+" ? value + rhs : value - rhs
        }
        return value
    }

    private static func parseTerm(_ tokens: inout [Token]) throws -> Int {
        var value = try parseFactor(&tokens)
        while let token = tokens.first, case let .operatorSymbol(op) = token, "*/".contains(op) {
            tokens.removeFirst()
            let rhs = try parseFactor(&tokens)
            value = op == "*" ? value * rhs : value / rhs
        }
        return value
    }

    private static func parseFactor(_ tokens: inout [Token]) throws -> Int {
        if let token = tokens.first {
            tokens.removeFirst()
            switch token {
            case .number(let value):
                return value
            case .dice(let count, let sides):
                guard count > 0, sides > 0 else { return 0 }
                return (1...count).reduce(0) { acc, _ in acc + Int.random(in: 1...sides) }
            case .parenthesisOpen:
                let value = try parseExpression(&tokens)
                guard let closing = tokens.first, case .parenthesisClose = closing else {
                    throw NSError(domain: "MismatchedParentheses", code: 1, userInfo: nil)
                }
                tokens.removeFirst()
                return value
            default:
                throw NSError(domain: "UnexpectedToken", code: 1, userInfo: nil)
            }
        }
        throw NSError(domain: "UnexpectedEndOfInput", code: 1, userInfo: nil)
    }
}
