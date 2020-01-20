//
//  SetLimitViewController.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/10/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit

class SetLimitViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var setLimitTextField: UITextField!
    @IBOutlet weak var limitLabel: UILabel!
    
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Actions
    
    /// Dismisses the view from the stack
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setLimitButtonTapped(_ sender: Any) {
        setNewLimit()
    }
    
    // MARK: - Functions
    
    func setNewLimit() {
        guard let limit = setLimitTextField.text else { return }
        if let myNumber = NumberFormatter().number(from: limit) {
            let myInt = myNumber.intValue
            UserController.shared.currentUser?.calorieLimit = myInt
            guard let user = UserController.shared.currentUser else { return }
            UserController.shared.createOrUpdateUser(user, firebaseID: user.firebaseID) { (success) in
                if success {
                    self.limitLabel.text = "Limit: \(user.calorieLimit)"
                    self.setLimitTextField.text = ""
                } else {
                    // present an error message to user
                }
            }
        }
    }
}


// MARK: - Extensions

extension SetLimitViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}
