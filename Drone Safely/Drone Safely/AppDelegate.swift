//
//  AppDelegate.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var current: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if Auth.auth().currentUser != nil {
            LoginHelper.presentMain()
        } else {
            LoginHelper.presentLogin()
        }

        return true
    }

}

