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
    @IBOutlet weak var pickerTextFieldComponents: UITextFieldAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        struct Text {
            let title: String
            let subtitle: String
        }
        
        let list = [Text(title: "Title 1", subtitle: "Subtitle 1"),
                    Text(title: "Title 2", subtitle: "Subtitle 2"),
                    Text(title: "Title 3", subtitle: "Subtitle 3")]
        
        pickerTextField.inputAction = InputPickerViewActionObject<Text>(list, { text in
            print(text.subtitle)
            return text.title
        })

        let items = ["lorem", "ipsum", "dolor", "sit", "amet"]
        pickerTextFieldComponents.inputAction = InputPickerViewComponentsAction([items, items], { $0.joined(separator: " - ") })
        
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
