//
//  LoginViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: BaseDroneSafelyViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var topLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    
    let reachability = Reachability()!
    var fromMap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromMap {
            skipButton.setTitle("Not now", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignTextFields()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let signup = segue.destination as? SignupViewController {
            signup.fromMap = fromMap
        }
    }

    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        resignTextFields()
        view.startLoadingAnimation()
        
        guard reachability.connection != .none else {
            view.stopLoadingAnimation()
            showAlert("Connection Error", message: "Seems that you don't have internet connection.")
            return
        }
        if let email = emailTextField.text, let password = passwordTextField.text, email.isValidEmail(), password.count > 0 {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                self.view.stopLoadingAnimation()
                if let error = error {
                    self.showAlert("Login Error", message: error.localizedDescription)
                    return
                }
                if self.fromMap {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "goMainStoryboard", sender: nil)
                }
            }
        } else {
            self.view.stopLoadingAnimation()
            showAlert("Login Error", message: "Email or password is not in the correct format.")
        }
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        if fromMap {
            dismiss(animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "goMainStoryboard", sender: nil)
        }
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        self.topLogoConstraint.constant = -82
        self.stackView.spacing = 4
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        self.topLogoConstraint.constant = 20
        self.stackView.spacing = 10
    }
    
}

// MARK: - TextFields configs

extension LoginViewController {
    func resignTextFields() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}
