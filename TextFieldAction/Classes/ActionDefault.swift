//
//  ActionDefault.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 02/04/20.
//

import Foundation

@available(*, deprecated, message: "Use UITextFieldAction with InputFormatTextAction")
class ActionDefault: TextFieldActionProtocol {
    
    var didChange: ((String) -> Void)?
    var textFormat: ((String) -> String)?
    
    required init(_ didChange: ((String) -> Void)?) {
        self.didChange = didChange
    }
    
    required init(_ textFormat: @escaping ((String) -> String)) {
        self.textFormat = textFormat
    }
    
    func event() -> UIControl.Event {
        return .editingChanged
    }
    
    func eventAction(_ textField: TextFieldAction) -> String {
        guard let text = textField.text else { return "" }
        return self.textFormat?(text) ?? ""
    }
}
