//
//  UserData.swift
//  AutorizationCenterHW1
//
//  Created by Сергей Калмыков on 6/23/19.
//  Copyright © 2019 Сергей Калмыков. All rights reserved.
//

import Foundation

class AccountingData {
    
    static func getStatus(user: User, completed:  (_ status: StateSegue) -> Void) {
        
        var status = StateSegue.forgetName
        
        let userDefault = UserDefaults.standard
        if let userName = userDefault.string(forKey: "Default"){
            if userName == user.name {
                if let userPas = userDefault.string(forKey: userName){
                    if userPas == user.pass {
                        status = StateSegue.correctEnter
                    } else {
                        status = StateSegue.forgetPass
                    }
                }
            }
        }
         completed(status)
    }
    static func getDefauldUser() -> [String: String]!{
        
        let userDefault = UserDefaults.standard
        guard  let userDef = userDefault.string(forKey: "Default") else {return nil}
        guard   let passDefault = userDefault.string(forKey: userDef) else {return nil}
        return ["key": userDef,"pas": passDefault]
    }
    
    static func saveData(for user: User) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(user.name, forKey: "Default")
        userDefault.setValue(user.pass, forKey: user.name)
        userDefault.synchronize()
    }
}
