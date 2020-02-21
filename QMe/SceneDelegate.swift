//
//  SceneDelegate.swift
//  QMe
//
//  Created by Mr. Nabeel on 1/31/20.
//  Copyright © 2020 Mr. Nabeel. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //////////////////////////////////////////
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            if getBool(key: logedinkey) {
                if getString(key: accTypekey) == "User" {
                    window.rootViewController = storyboardView(boardName: "main", pageID: "userDashboardVC")
                }
                else{
                    window.rootViewController = storyboardView(boardName: "main", pageID: "adminDashboardVC")
                }
            }
            else{
                if getBool(key: isUser) {
                    window.rootViewController = storyboardView(boardName: "main", pageID: "loginVC")
                }
                else{
                    window.rootViewController = storyboardView(boardName: "main", pageID: "accountypeVC")
                }
            }
            
            self.window = window
            window.makeKeyAndVisible()
        }
        //////////////////////////////////////////
    }


}

