//
//  PasscodeManager.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare.

import Foundation

class PasscodeManager {
    
    static var shared = PasscodeManager()
    var limitRetry : Int = 0
    var dateToEnterBackground : Date?
    var dateToEnterForground : Date?
    var second = 00
    var minute = 00
    
    var hasPasscode : Bool {
        get {
            guard KeychainService.shared.load(key: "passcode") != nil else {return false}
            return true
        }
    }
    
    var passcode : String {
        get {
            guard let data = KeychainService.shared.load(key: "passcode") else {return ""}
            let str = String(decoding: data, as: UTF8.self)
            return str
        }
    }
    
    var passcodeActive : Bool {
        get{
            if PasscodeManager.shared.limitRetry <= 5 {
                return true
            } else {
                return false
            }
        }
        
    }
    
}
