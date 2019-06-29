//
//  SecondViewController.swift
//  AutorizationCenterHW1
//
//  Created by Сергей Калмыков on 6/23/19.
//  Copyright © 2019 Сергей Калмыков. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var currentUser: User!
    var currentStatus: StateSegue!
    
    @IBOutlet var cuurentStateLabel: UILabel!    
    @IBOutlet var userMessage: UILabel!
    @IBOutlet var textFieldLabel: UITextField!
    @IBOutlet var buttonLabel: UIButton!
    @IBOutlet var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        guard let currentUser = currentUser else { return }
        guard let currentStatus = currentStatus else { return }
        
        switch currentStatus {
        case .correctEnter:
            cuurentStateLabel.text = "world is here"
        case .forgetName:
            guard let name = textFieldLabel.text else { return }
            guard let pass = passTextField.text else { return }
            if !name.isEmpty {
                currentUser.name = name
                currentUser.pass = pass
                AccountingData.saveData(for: currentUser)
            }
        case .forgetPass:
            guard let name = textFieldLabel.text else { return }
            guard let pass = passTextField.text else { return }
            if !pass.isEmpty {
                currentUser.name = name
                currentUser.pass = pass
                AccountingData.saveData(for: currentUser)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    func setValue(){
        
        guard let currentUser = currentUser else { return }
        guard let currentStatus = currentStatus else { return }
        
        switch currentStatus {
        case .correctEnter:
            cuurentStateLabel.text = "world is here"
            userMessage.text = "welcome \(currentUser.name)"
            textFieldLabel.isHidden = true
            passTextField.isHidden = true
            buttonLabel.setTitle("Enter", for: .normal)
            
        case .forgetName:
            cuurentStateLabel.text = "Forget Name?"
            userMessage.text = "Enter your name and new pass in textfield"
            textFieldLabel.isHidden = false
            passTextField.isHidden = false
            buttonLabel.setTitle("Save", for: .normal)
             textFieldLabel.text = currentUser.name
             passTextField.text = currentUser.pass
            
        case .forgetPass:
            cuurentStateLabel.text = "Forget Pass?"
            userMessage.text = "\(currentUser.name) enter new pass"
            textFieldLabel.isHidden = true
            passTextField.isHidden = false
            buttonLabel.setTitle("Save", for: .normal)
            textFieldLabel.text = currentUser.name
            passTextField.text = currentUser.pass
        }
    }
}
