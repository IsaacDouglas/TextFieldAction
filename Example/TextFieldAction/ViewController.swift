//
//  ViewController.swift
//  TextFieldAction
//
//  Created by IsaacDouglas on 04/02/2020.
//  Copyright (c) 2020 IsaacDouglas. All rights reserved.
//

import UIKit
import TextFieldAction

class ViewController: UIViewController {

    @IBOutlet weak var cpfTextField: UITextFieldAction!
    @IBOutlet weak var cellphoneTextField: UITextFieldAction!
    @IBOutlet weak var pickerTextField: UITextFieldAction!
    @IBOutlet weak var datePickerTextField: UITextFieldAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = ["lorem", "ipsum", "dolor", "sit", "amet"]
        pickerTextField.inputAction = InputPickerViewAction(items, { $0 })
        
        cpfTextField.inputAction = InputFormatTextAction({ $0.CPFFormat() })
        cpfTextField.keyboardType = .numberPad
        
        cellphoneTextField.inputAction = InputFormatTextAction({ $0.cellphoneFormat() })
        cellphoneTextField.keyboardType = .numberPad
        
        let inputDatePickerAction = InputDatePickerAction({ $0.format })
        inputDatePickerAction.dataPicker.datePickerMode = .date
        datePickerTextField.inputAction = inputDatePickerAction
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
