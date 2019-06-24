//
//  MainViewController.swift
//  AutorizationCenterHW1
//
//  Created by Сергей Калмыков on 6/23/19.
//  Copyright © 2019 Сергей Калмыков. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var currentUser: User!
    private var currentStatus: StateSegue!
    
    @IBOutlet var userFailedLabel: UILabel!
    @IBOutlet var userNameLabel: UITextField!
    @IBOutlet var passLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.layer.cornerRadius = 10
        passLabel.layer.cornerRadius = 10
        userFailedLabel.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainSegue" {
            guard let secondController = segue.destination as? SecondViewController else { return }
            secondController.currentUser = currentUser
            secondController.currentStatus = currentStatus
        }
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        
        guard let userName = userNameLabel.text  else {
            print("uncoorect name" ); return
        }
        guard let pass = passLabel.text else {
            print("uncoorect pass"); return
        }
        if !userName.isEmpty && !pass.isEmpty {
           currentUser =  (currentUser == nil) ? User.init(name: "", pass: "") : currentUser
            AccountingData.getStatus(user: currentUser) { (stateSegue) in
                switch stateSegue{
                case .correctEnter:
                    self.userFailedLabel.isHidden = true
                    self.currentStatus = .correctEnter
                case .forgetName:
                    self.userFailedLabel.isHidden = true
                    self.currentStatus = .forgetName
                case.forgetPass:
                    self.userFailedLabel.isHidden = true
                    self.currentStatus = .forgetPass
                }
            }
            tryPerfomSegue()
        } else {
            print("is epty data "); return
        }
    }
    
    @IBAction func forgetNameAction(_ sender: UIButton) {
        currentStatus = StateSegue.forgetName
        currentUser =  (currentUser == nil) ? User.init(name: "", pass: "") : currentUser
        tryPerfomSegue()
    }
    
    @IBAction func forgetPassAction(_ sender: UIButton) {
        currentStatus = StateSegue.forgetPass
        currentUser =  (currentUser == nil) ? User.init(name: "", pass: "") : currentUser
        tryPerfomSegue()
    }
    @IBAction func unwin(_ segue: UIStoryboardSegue) {
        if segue.identifier == "mainSegue" {
            
            guard let secondController = segue.source as? SecondViewController else { return }
            let curUser = secondController.currentUser
            userNameLabel.text = curUser?.name
            passLabel.text = curUser?.pass
        }
    }
    private func tryPerfomSegue() {
        performSegue(withIdentifier: "mainSegue", sender: nil)
    }
}
