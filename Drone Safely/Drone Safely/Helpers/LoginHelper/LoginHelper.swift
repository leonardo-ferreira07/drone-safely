//
//  LoginHelper.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import FirebaseAuth

struct LoginHelper {
    
    static var userIsNotLoggedIn: Bool {
        return Auth.auth().currentUser == nil
    }
    
    static func presentLogin(fromMap: Bool = false, mapViewController: UIViewController? = nil) {
        let loginStoryboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController: UINavigationController = loginStoryboard.instantiateViewController(withIdentifier: "loginController") as! UINavigationController
        if fromMap {
            if let login = viewController.viewControllers.first as? LoginViewController {
                login.fromMap = true
            }
            mapViewController?.show(viewController, sender: nil)
        } else {
        
            AppDelegate.current?.window?.rootViewController = viewController
        
            AppDelegate.current?.window?.makeKeyAndVisible()
        }
    }
    
    static func presentMain() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
        
        AppDelegate.current?.window?.rootViewController = viewController
        
        AppDelegate.current?.window?.makeKeyAndVisible()
    }
    
}
