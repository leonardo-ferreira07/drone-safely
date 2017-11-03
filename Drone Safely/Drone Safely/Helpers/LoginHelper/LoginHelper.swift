//
//  LoginHelper.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

struct LoginHelper {
    
    static func presentLogin() {
        let loginStoryboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController: UINavigationController = loginStoryboard.instantiateViewController(withIdentifier: "loginController") as! UINavigationController
        
        AppDelegate.current?.window?.rootViewController = viewController
        
        AppDelegate.current?.window?.makeKeyAndVisible()
    }
    
    static func presentMain() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
        
        AppDelegate.current?.window?.rootViewController = viewController
        
        AppDelegate.current?.window?.makeKeyAndVisible()
    }
    
}
