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

    @IBOutlet weak var cpfTextField: TextFieldAction!
    @IBOutlet weak var cellphoneTextField: TextFieldAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cpfTextField.actionProtocol = TextFieldAction.actionProtocol({ $0.CPFFormat() })
        cpfTextField.keyboardType = .numberPad
        
        cellphoneTextField.actionProtocol = TextFieldAction.actionProtocol({ $0.cellphoneFormat() })
        cellphoneTextField.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
