//
//  UserData.swift
//  AutorizationCenterHW1
//
//  Created by Сергей Калмыков on 6/23/19.
//  Copyright © 2019 Сергей Калмыков. All rights reserved.
//

import Foundation

class AccountingData {
    
    static func getStatus(user: User, completed: @escaping (_ status: StateSegue) -> Void) {
     
      let userDefault = UserDefaults.standard
      var status = StateSegue.forgetName
        
        if let userName = userDefault.string(forKey: user.name){
            if let _ = userDefault.string(forKey: userName) {
               status = .correctEnter
            } else {
                status = .forgetPass
            }
        }
        completed(status)
    }
    
    static func saveData(for user: User) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(user.name, forKey: user.name)
        userDefault.setValue(user.pass, forKey: user.name)
        userDefault.synchronize()
    }
}
