//
//  SceneDelegate.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare. All rights reserved.
//

import UIKit
import SwiftDate

@available(iOS 13.0, *)
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
        if NavigatorManager.shared.backgroundMode && !NavigatorManager.shared.screenLocked {
            NavigatorManager.shared.navigateToLockPage()
        }
        if NavigatorManager.shared.screenLocked {
            NavigatorManager.shared.dateToEnterForground = Date()
            NavigatorManager.shared.second += Int(NavigatorManager.shared.dateToEnterBackground?.getInterval(toDate: NavigatorManager.shared.dateToEnterForground ?? Date(), component: .second) ?? 0)
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        NavigatorManager.shared.backgroundMode = true
        NavigatorManager.shared.dateToEnterBackground = Date()
    }
    
    
}

