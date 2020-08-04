//
//  SceneDelegate.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare. All rights reserved.
//

import UIKit
import SwiftDate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        if PasscodeManager.shared.backgroundMode && !PasscodeManager.shared.screenLocked {
            PasscodeManager.shared.navigateToLockPage(view: window?.rootViewController ?? UIViewController())
        }
        if PasscodeManager.shared.screenLocked {
            PasscodeManager.shared.dateToEnterForground = Date()
            PasscodeManager.shared.second += Int(PasscodeManager.shared.dateToEnterBackground?.getInterval(toDate: PasscodeManager.shared.dateToEnterForground ?? Date(), component: .second) ?? 0)
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        PasscodeManager.shared.backgroundMode = true
        PasscodeManager.shared.dateToEnterBackground = Date()
    }
    
    
}

