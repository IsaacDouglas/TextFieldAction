//
//  Date.swift
//  TextFieldAction_Example
//
//  Created by Isaac Douglas on 16/04/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension Date {
    var format: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
