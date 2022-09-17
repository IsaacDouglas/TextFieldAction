//
//  UITextFieldActionType.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 15/04/20.
//

import UIKit

public protocol InputActionTypeBase: AnyObject {
    func event() -> UIControl.Event
    func inputView(_ textField: UITextFieldAction) -> UIView?
    func eventAction(_ textField: UITextFieldAction)
    func beginAction(_ textField: UITextFieldAction)
}

public extension InputActionTypeBase {
    func event() -> UIControl.Event { return .editingChanged }
    func inputView(_ textField: UITextFieldAction) -> UIView? { return nil }
    func beginAction(_ textField: UITextFieldAction) { }
}

public protocol InputActionType: InputActionTypeBase {
    associatedtype T
    
    var didChange: ((T) -> String) { get set }
    var inputAndResultHandler: ((T, String) -> Void)? { get set }
    
    init(_ didChange: @escaping ((T) -> String))
}
