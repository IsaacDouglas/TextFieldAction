//
//  TextFieldActionProtocol.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 02/04/20.
//

import UIKit

@available(*, deprecated, message: "Use InputActionType")
public protocol TextFieldActionProtocol {
    
    var didChange: ((String) -> Void)? { get set }
    
    init(_ didChange: ((String) -> Void)?)
    
    func event() -> UIControl.Event
    func eventAction(_ textField: TextFieldAction) -> String
    func inputView(_ textField: TextFieldAction) -> UIView?
    func begin(_ textField: TextFieldAction)
}

public extension TextFieldActionProtocol {
    func inputView(_ textField: TextFieldAction) -> UIView? {
        return nil
    }
    
    func begin(_ textField: TextFieldAction) { }
}
