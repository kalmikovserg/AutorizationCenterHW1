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
        
        NotificationCenter.default.addObserver( self , selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification , object: nil)
        
        NotificationCenter.default.addObserver( self , selector: #selector(keyboardHide), name: UIResponder.keyboardDidHideNotification , object: nil)
        
    }
    
    @objc func keyboardShow(notification : Notification) {
        guard let userInfo = notification.userInfo  else { return }
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + keyboardSize.height )
    }
    
    @objc func keyboardHide() {
      (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setDefUser()
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
            
            currentUser =  User.init(name: userName, pass: pass)
            
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
                self.tryPerfomSegue()
            }
            
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
        guard let userName = userNameLabel.text else {
            print("uncorrect user") ; return
        }
        
        if !(userName == "")  {
            currentUser =  (currentUser == nil) ? User.init(name: userName, pass: "") : currentUser
            tryPerfomSegue()} else {
            print("Enter name")
        }
        
    }
    @IBAction func unwin(_ segue: UIStoryboardSegue) {
        
    }
    
    private func setDefUser() {
        var defaultUser = AccountingData.getDefauldUser()
        if defaultUser != nil {
            userNameLabel.text = defaultUser?["key"]
            passLabel.text = defaultUser?["pas"]
        }
    }
    private func tryPerfomSegue() {
        performSegue(withIdentifier: "mainSegue", sender: nil)
    }
}
