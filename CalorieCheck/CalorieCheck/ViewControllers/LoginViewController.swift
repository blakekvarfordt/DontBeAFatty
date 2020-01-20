//
//  LoginViewController.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/12/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: TextFieldDesignable!
    @IBOutlet weak var passwordTextField: TextFieldDesignable!
    @IBOutlet weak var usernameTextField: TextFieldDesignable!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        Segues.presentViewController(vc: self, name: SegueConstants.main, id: SegueConstants.register)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        authenticateAndCreateUser()
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        login()
    }
    @IBAction func cancelRegistrationButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func authenticateAndCreateUser() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        FirebaseManager.authenticateAndCreateUser(email: email, password: password) { (result) in
            switch result {
            case .failure(let e):
                print(e, FirebaseErrors.FailedCreation)
            case .success:
                self.createUser()
            }
        }
    }
    
    func login() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        FirebaseManager.signInAuthentication(email: email, password: password) { (success) in
            if success {
                Segues.presentViewController(vc: self, name: SegueConstants.main, id: SegueConstants.input)
            } else {
                // present error to user or something
            }
        }
    }
    
    func createUser() {
        guard let username = usernameTextField.text,
            let uid = FirebaseManager.userID else { return }
        let user = User(name: username, calorieLimit: 0, currentCalories: 0, firebaseID: uid)
        UserController.shared.createOrUpdateUser(user, firebaseID: uid) { (success) in
            if success {
                Segues.presentViewController(vc: self, name: SegueConstants.main, id: SegueConstants.input)
                print("final success creating user!!!")
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Animations.transitionUpwards(view: stackView, height: 120)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Animations.transitionDownwards(view: stackView, height: 120)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
