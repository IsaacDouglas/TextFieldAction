//
//  String.swift
//  TextFieldAction_Example
//
//  Created by Isaac Douglas on 02/04/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension String {
    
    func CPFFormat() -> String {
        var resultString = String()
       
        self.numbers()
            .enumerated()
            .forEach({ (index, character) in
                if index == 9 {
                    resultString.append("-")
                } else if index % 3 == 0 && index > 0 {
                    resultString.append(".")
                }
                resultString.append(character)
            })
        return String(resultString.prefix(14))
    }
    
    func cellphoneFormat() -> String {
        guard self.count < 16 else { return String(self.prefix(15)) }
        
        var resultString = String()
        let text = self.numbers()
        
        text.enumerated()
            .forEach({ (index, character) in
                if index == 0 {
                    resultString.append("(")
                }else if index == 2 {
                    resultString.append(") ")
                }else if index > 2 && index == (text.count - 4) {
                    resultString.append("-")
                }
                resultString.append(character)
            })
        return resultString
    }
    
    func numbers() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var isValidCPF: Bool {
        let numbers = compactMap({ Int(String($0)) })
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        func digitCalculator(_ slice: ArraySlice<Int>) -> Int {
            var number = slice.count + 2
            let digit = 11 - slice.reduce(into: 0) {
                number -= 1
                $0 += $1 * number
                } % 11
            return digit > 9 ? 0 : digit
        }
        let dv1 = digitCalculator(numbers.prefix(9))
        let dv2 = digitCalculator(numbers.prefix(10))
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    func codeCardFormat() -> String {
        return String(self.numbers().prefix(4))
    }
    
    func zipCodeFormat() -> String {
        var resultString = String()
        
        self.numbers()
            .enumerated()
            .forEach({ (index, character) in
                if index == 2 {
                    resultString.append(".")
                } else if index == 5 {
                    resultString.append("-")
                }
                resultString.append(character)
            })
        return String(resultString.prefix(10))
    }
    
    func dateCardFormat() -> String {
        var resultString = String()
        
        self.numbers()
            .enumerated()
            .forEach({ (index, character) in
                if index == 2 {
                    resultString.append("/")
                }
                resultString.append(character)
            })
        return String(resultString.prefix(7))
    }
    
    func cardFormat() -> String {
        var resultString = String()
        
        self.numbers()
            .enumerated()
            .forEach({ (index, character) in
                if index % 4 == 0 && index > 0 {
                    resultString.append(" ")
                }
                resultString.append(character)
            })
        return String(resultString.prefix(19))
    }
}
