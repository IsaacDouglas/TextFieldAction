//
//  TextFieldAction.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 02/04/20.
//

import UIKit

public class TextFieldAction: UITextField {
    
    public var editAction: Bool = true
    private var action: ((TextFieldAction) -> String)?
    
    public var actionProtocol: TextFieldActionProtocol? {
        didSet {
            guard let action = self.actionProtocol else { return }
            self.inputView = action.inputView(self)
            self.setAction(event: action.event(), action: action.eventAction(_:))
        }
    }
    
    private func setAction(event: UIControl.Event = .editingChanged, action: @escaping ((TextFieldAction) -> String)) {
        self.action = action
        self.addTarget(self, action: #selector(self.selectorAction), for: event)
        self.addTarget(self, action: #selector(self.beginAction), for: .editingDidBegin)
    }
    
    @objc private func selectorAction() {
        guard let newText = self.action?(self) else { return }
        self.actionProtocol?.didChange?(newText)
        self.text = newText
    }
    
    @objc private func beginAction() {
        self.actionProtocol?.begin(self)
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return self.editAction ? super.canPerformAction(action, withSender: sender) : false
    }
}

public extension TextFieldAction {
    static func actionProtocol(_ textFormat: @escaping ((String) -> String)) -> TextFieldActionProtocol {
        return ActionDefault(textFormat)
    }
    
    static func pickerAction(items: [String], _ didChange: ((String) -> Void)?) -> TextFieldActionProtocol {
        return PickerAction(items: items, didChange)
    }
}
