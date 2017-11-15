//
//  SignupViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 03/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIBarButtonItem!
    
    let reachability = Reachability()!
    var fromMap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeChanges()
        enableSignUpButton(false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignTextFields()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func signUpButtonPressed(_ sender: UIBarButtonItem) {
        resignTextFields()
        view.startLoadingAnimation()
        
        guard reachability.connection != .none else {
            view.stopLoadingAnimation()
            showAlert("Connection Error", message: "Seems that you don't have internet connection.")
            return
        }
        if let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, email.isValidEmail(), !password.isEmpty, !name.isEmpty {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.view.stopLoadingAnimation()
                    self.showAlert("Sign Up Error", message: error.localizedDescription)
                    return
                }
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges { (error) in
                    self.view.stopLoadingAnimation()
                    if let error = error {
                        print(error)
                        return
                    }
                    if self.fromMap {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.performSegue(withIdentifier: "goMainStoryboard", sender: nil)
                    }
                }
            }
        } else {
            self.view.stopLoadingAnimation()
            showAlert("Login Error", message: "Email or password is not in the correct format.")
        }
    }
    
}

// MARK: - TextFields configs

extension SignupViewController: UITextFieldDelegate {
    func resignTextFields() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func observeChanges() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if !(nameTextField.text?.isEmpty ?? false) && !(emailTextField.text?.isEmpty ?? false) && !(passwordTextField.text?.isEmpty ?? false) {
            enableSignUpButton(true)
        }
    }
    
    func enableSignUpButton(_ enabled: Bool) {
        signUpButton.isEnabled = enabled
    }
    
}
