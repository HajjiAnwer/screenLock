//
//  PasscodeManager.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare.

import Foundation
import UIKit

class PasscodeManager {
    
    var keyChainClassItem : KeychainCalssItemEnum
    
    init(keyChainClassItem : KeychainCalssItemEnum) {
        self.keyChainClassItem = keyChainClassItem
    }
    
    var hasPasscode : Bool {
        get {
            do {
                _ = try KeychainService(keychainClass: keyChainClassItem.keychainItem).load(key: "passcode")
                return true
            } catch {
                return false
            }
        }
    }
    
    var passcode : String {
        get {
            do {
                guard let data = try KeychainService(keychainClass: keyChainClassItem.keychainItem).load(key: "passcode") else {return ""}
                let str = String(decoding: data, as: UTF8.self)
                return str
            } catch {
                return ""
            }
        }
    }
    
    var sessionActive : Bool {
        get{
            if NavigatorManager.shared.limitRetry <= 5 {
                return true
            } else {
                return false
            }
        }
    }
    
}
