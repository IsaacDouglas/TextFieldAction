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
}
