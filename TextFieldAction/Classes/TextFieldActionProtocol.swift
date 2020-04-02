//
//  TextFieldActionProtocol.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 02/04/20.
//

import UIKit

public protocol TextFieldActionProtocol {
    
    var didChange: ((String) -> Void)? { get set }
    
    init(_ didChange: ((String) -> Void)?)
    
    func event() -> UIControl.Event
    func eventAction(_ textField: TextFieldAction) -> String
}
