//
//  PasscodeManager.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare.

import Foundation
import UIKit

class PasscodeManager {
    
    static var shared = PasscodeManager()
    var limitRetry : Int = 0
    var dateToEnterBackground : Date?
    var dateToEnterForground : Date?
    var second = 00
    var minute = 00
    var privacyProtectionWindow : UIWindow?
    var backgroundMode : Bool = false
    var screenLocked : Bool = false
    
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
    
    func navigateToMainPage(view : UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "main") as! MainViewController
        vc.sourceController = 1
        view.show(vc, sender: nil)
    }
    
    func navigateToLockPage(view : UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "lockScreen") as! ViewController
        view.show(vc, sender: nil)
    }
    
    func showLockScreen() {
        privacyProtectionWindow = UIWindow(frame: UIScreen.main.bounds)
        privacyProtectionWindow?.rootViewController = ViewController()
        privacyProtectionWindow?.windowLevel = .alert + 1
        privacyProtectionWindow?.makeKeyAndVisible()
    }
    
    func hideLockScreen() {
        privacyProtectionWindow?.isHidden = true
        privacyProtectionWindow = nil
    }
    
}
