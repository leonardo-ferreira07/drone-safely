//
//  OnTheMapViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import Firebase

class BaseDroneSafelyViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        verifyLoggedUserUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func deleteSessionPressed(_ sender: Any) {
        view.startLoadingAnimation()
        logoutButton(enabled: false)
        var hadError = false
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            hadError = true
            print ("Error signing out: %@", signOutError)
        }
        if !hadError {
            if AppDelegate.current?.window?.rootViewController is UITabBarController {
                LoginHelper.presentLogin()
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
        view.stopLoadingAnimation()
    }
    
    @IBAction func refreshStudentsLocationsPressed(_ sender: Any) {
        
    }
    
    @IBAction func addStudentLocationPressed(_ sender: Any) {
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
    
}

// MARK: - UI Controls

extension BaseDroneSafelyViewController {
    func logoutButton(enabled: Bool) {
        logoutButton.isEnabled = enabled
    }
    
    func refreshButton(enabled: Bool) {
        refreshButton.isEnabled = enabled
    }
    
    func verifyLoggedUserUI() {
        if logoutButton != nil {
            if LoginHelper.userIsNotLoggedIn {
                logoutButton(enabled: false)
            } else {
                logoutButton(enabled: true)
            }
        }
    }
}

// MARK: - Keyboard notifications

extension BaseDroneSafelyViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}
