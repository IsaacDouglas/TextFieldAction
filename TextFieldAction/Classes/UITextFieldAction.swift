//
//  UITextFieldAction.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 15/04/20.
//

import UIKit

public class UITextFieldAction: UITextField {
    
    public var editAction: Bool = true
    
    public var inputAction: InputActionTypeBase? {
        didSet {
            guard let action = self.inputAction else { return }
            self.inputView = action.inputView(self)
            self.addTarget(self, action: #selector(self.eventAction), for: action.event())
            self.addTarget(self, action: #selector(self.beginAction), for: .editingDidBegin)
        }
    }
    
    @objc private func eventAction() {
        self.inputAction?.eventAction(self)
    }
    
    @objc private func beginAction() {
        self.inputAction?.beginAction(self)
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return self.editAction ? super.canPerformAction(action, withSender: sender) : false
    }
}
