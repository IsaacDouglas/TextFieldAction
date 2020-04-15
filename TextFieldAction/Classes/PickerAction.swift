//
//  PickerAction.swift
//  TextFieldAction
//
//  Created by Isaac Douglas on 13/04/20.
//

import UIKit

class PickerAction: TextFieldActionProtocol {
    
    var didChange: ((String) -> Void)?
    var itemsPicker = [String]()
    private var oldText: String?
    
    required init(_ didChange: ((String) -> Void)?) {
        self.didChange = didChange
    }
    
    init(items: [String], _ didChange: ((String) -> Void)?) {
        self.itemsPicker = items
        self.didChange = didChange
    }
    
    func event() -> UIControl.Event {
        return .editingChanged
    }
    
    func eventAction(_ textField: TextFieldAction) -> String {
        guard let text = textField.text else { return "" }
        let newText = text.isEmpty ? "" : self.oldText
        return newText ?? ""
    }
    
    func inputView(_ textField: TextFieldAction) -> UIView? {
        let picker = PikerViewAction()
        picker.items = self.itemsPicker
        picker.setAction(action: { picker in
            guard let item = picker.itemSelected else { return }
            textField.text = item
            self.oldText = item
            self.didChange?(item)
        })
        return picker
    }

    func begin(_ textField: TextFieldAction) {
        guard let item = self.itemsPicker.first else { return }
        
        if textField.text == nil || textField.text!.isEmpty {
            self.didChange?(item)
            textField.text = item
        }
    }
    
}
 
class PikerViewAction: UIPickerView {
    internal var action: ((PikerViewAction) -> ())?
    
    var items = [String]()
    var itemSelected: String?
    
    func setAction(action: @escaping ((PikerViewAction) -> ())) {
        self.action = action
        self.delegate = self
        self.dataSource = self
    }
}

extension PikerViewAction: UIPickerViewDelegate, UIPickerViewDataSource {
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
