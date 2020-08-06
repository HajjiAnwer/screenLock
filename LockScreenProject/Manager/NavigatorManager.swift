//
//  Navigator.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/6/20.
//  Copyright © 2020 spare.

import Foundation
import UIKit

class NavigatorManager {
    var unhadledErrorMessage = "Unhandled Error"
    var service : String = Bundle.main.bundleIdentifier ?? "MyService"
    var limitRetry : Int = 0
    var dateToEnterBackground : Date?
    var dateToEnterForground : Date?
    var second = 00
    var minute = 00
    var backgroundMode : Bool = false
    var screenLocked : Bool = false
    
    static var shared = NavigatorManager()
    
    func navigateToMainPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "main") as! MainViewController
        vc.modalPresentationStyle = .fullScreen
        vc.sourceController = 1
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    func navigateToLockPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "lockScreen") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
}
