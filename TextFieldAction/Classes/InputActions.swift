//
//  InputActions.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 15/04/20.
//

import UIKit

// MARK: - InputFormatTextAction
public class InputFormatTextAction: InputActionType {
    public typealias T = String
    
    public var didChange: ((String) -> String)
    
    required public init(_ didChange: @escaping ((String) -> String)) {
        self.didChange = didChange
    }
    
    public func eventAction(_ textField: UITextFieldAction) {
        guard let text = textField.text else { return }
        textField.text = self.didChange(text)
    }
}

// MARK: - InputPickerViewAction
public class InputPickerViewAction: InputActionType {
    public typealias T = String
    
    public var didChange: ((String) -> String)
    public var items = [String]()
    
    required public init(_ didChange: @escaping ((String) -> String)) {
        self.didChange = didChange
    }
    
    required public init(_ items: [String], _ didChange: @escaping ((String) -> String)) {
        self.didChange = didChange
        self.items = items
    }
    
    public func eventAction(_ textField: UITextFieldAction) { }
    
    public func beginAction(_ textField: UITextFieldAction) {
        guard let first = self.items.first else { return }
        if textField.text == nil || textField.text!.isEmpty {
            textField.text = self.didChange(first)
        }
    }
    
    public func inputView(_ textField: UITextFieldAction) -> UIView? {
        let picker = UIPickerViewAction()
        picker.items = self.items
        picker.setAction(action: { picker in
            guard let item = picker.itemSelected else { return }
            textField.text = self.didChange(item)
        })
        return picker
    }
}

fileprivate class UIPickerViewAction: UIPickerView {
    internal var action: ((UIPickerViewAction) -> Void)?
    
    var items = [String]()
    var itemSelected: String?
    
    func setAction(action: @escaping ((UIPickerViewAction) -> Void)) {
        self.action = action
        self.delegate = self
        self.dataSource = self
    }
}

extension UIPickerViewAction: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.itemSelected = self.items[row]
        self.action?(self)
    }
}

// MARK: - InputDatePickerAction
public class InputDatePickerAction: InputActionType {
    public typealias T = Date
    
    public var didChange: ((Date) -> String)
    
    public let dataPicker: UIDatePicker
    
    required public init(_ didChange: @escaping ((Date) -> String)) {
        self.didChange = didChange
        self.dataPicker = UIDatePickerViewAction()
    }
    
    public func eventAction(_ textField: UITextFieldAction) { }
    
    public func inputView(_ textField: UITextFieldAction) -> UIView? {
        guard let dataPicker = self.dataPicker as? UIDatePickerViewAction else { return nil }
        dataPicker.setAction(event: .valueChanged, action: { datePicker in
            let date = datePicker.date
            textField.text = self.didChange(date)
        })
        return dataPicker
    }
}

fileprivate class UIDatePickerViewAction: UIDatePicker {
    private var action: ((UIDatePickerViewAction) -> Void)?
    
    func setAction(event: UIControl.Event, action: @escaping ((UIDatePickerViewAction) -> Void)) {
        self.action = action
        self.addTarget(self, action: #selector(self.eventAction), for: event)
    }
    
    @objc private func eventAction() {
        self.action?(self)
    }
}

// MARK: - InputPickerViewComponentsAction
public class InputPickerViewComponentsAction: InputActionType {
    public typealias T = [String]
    
    public var didChange: (([String]) -> String)
    public var items = [[String]]()
    
    required public init(_ didChange: @escaping (([String]) -> String)) {
        self.didChange = didChange
    }
    
    required public init(_ items: [[String]], _ didChange: @escaping (([String]) -> String)) {
        self.didChange = didChange
        self.items = items
    }
    
    public func eventAction(_ textField: UITextFieldAction) { }
    
    public func beginAction(_ textField: UITextFieldAction) {
        let first = self.items
            .filter({ !$0.isEmpty })
            .map({ $0[0] })
        
        if first.count == self.items.count && (textField.text == nil || textField.text!.isEmpty) {
            textField.text = self.didChange(first)
        }
    }
    
    public func inputView(_ textField: UITextFieldAction) -> UIView? {
        let picker = UIPickerViewComponentsAction()
        picker.items = self.items
        
        let first = self.items
            .filter({ !$0.isEmpty })
            .map({ $0[0] })
        
        if first.count == self.items.count {
            picker.itemSelected = first
        } else {
            picker.itemSelected = (0 ..< self.items.count).map({ _ in "" })
        }
        
        picker.setAction(action: { picker in
            let item = picker.itemSelected
            textField.text = self.didChange(item)
        })
        return picker
    }
}

fileprivate class UIPickerViewComponentsAction: UIPickerView {
    internal var action: ((UIPickerViewComponentsAction) -> Void)?
    
    var items = [[String]]()
    var itemSelected = [String]()
    
    func setAction(action: @escaping ((UIPickerViewComponentsAction) -> Void)) {
        self.action = action
        self.delegate = self
        self.dataSource = self
    }
}

extension UIPickerViewComponentsAction: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.items[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.itemSelected[component] = self.items[component][row]
        self.action?(self)
    }
}
