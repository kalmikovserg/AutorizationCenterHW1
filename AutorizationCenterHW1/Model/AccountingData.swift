//
//  UserData.swift
//  AutorizationCenterHW1
//
//  Created by Сергей Калмыков on 6/23/19.
//  Copyright © 2019 Сергей Калмыков. All rights reserved.
//

import Foundation

class AccountingData {
    
    static func getStatus(user: User, completed: (_ status: StateSegue)->()) {
     
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
}
