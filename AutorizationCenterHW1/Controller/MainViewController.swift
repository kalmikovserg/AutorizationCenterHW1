//
//  MainViewController.swift
//  AutorizationCenterHW1
//
//  Created by Сергей Калмыков on 6/23/19.
//  Copyright © 2019 Сергей Калмыков. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
   
    @IBOutlet var userFailedLabel: UILabel!
    @IBOutlet var userNameLabel: UITextField!
    @IBOutlet var passLabel: UITextField!
    @IBOutlet var forgetNameLabel: UIButton!
    @IBOutlet var forgetPassLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.layer.cornerRadius = 10
        passLabel.layer.cornerRadius = 10
        userFailedLabel.isHidden = true
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        
        guard let userName = userNameLabel.text  else {
            print("uncoorect name" ); return
        }
        guard let pass = passLabel.text else {
            print("uncoorect pass"); return
        }
        
        if !userName.isEmpty && !pass.isEmpty {
        let currentUser = User.init(name: userName, pass: pass)
            
            AccountingData.getStatus(user: currentUser) { (stateSegue) in
                
                switch stateSegue{
                case .correctEnter:
                  self.userFailedLabel.isHidden = true
                case .forgetName:
                   self.userFailedLabel.isHidden = false
                case.forgetPass:
                   self.userFailedLabel.isHidden = false
                }
            }
            
        } else {
            print("is epty data "); return
        }
    }
    @IBAction func unwin(_ segue: UIStoryboardSegue) {
    }
}
