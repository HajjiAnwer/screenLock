//
//  AppDelegate.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare. All rights reserved.
//

import UIKit
import SwiftDate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var keychainClassItem = GenericPasswordQueryable(service: "com.spare.money.LockScreenProject")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NavigatorManager.shared.backgroundMode = true
        NavigatorManager.shared.dateToEnterBackground = Date()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if NavigatorManager.shared.backgroundMode && !NavigatorManager.shared.screenLocked {
            NavigatorManager.shared.navigateToLockPage()
        }
        if NavigatorManager.shared.screenLocked {
            NavigatorManager.shared.dateToEnterForground = Date()
            NavigatorManager.shared.second += Int(NavigatorManager.shared.dateToEnterBackground?.getInterval(toDate: NavigatorManager.shared.dateToEnterForground ?? Date(), component: .second) ?? 0)
        }
    }


}

