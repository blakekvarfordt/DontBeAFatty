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
    

    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
    
    
    func authenticateUser() {
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
    
    func createUser() {
        guard let username = usernameTextField.text,
            let uid = Auth.auth().currentUser?.uid else { return }
        let user = User(name: username, calorieLimit: 0, firebaseID: uid)
        UserController.shared.createOrUpdateUser(user) { (success) in
            if success {
                Segues.presentViewController(vc: self, name: SegueConstants.main, id: SegueConstants.input)
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
