//
//  InputViewController.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/10/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import UIKit
import FirebaseFirestore

class InputViewController: UIViewController {
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var currentCaloriesLabel: UILabel!
    @IBOutlet weak var foodTextField: TextFieldDesignable!
    @IBOutlet weak var caloriesTextField: TextFieldDesignable!
    @IBOutlet weak var limitLabel: LabelDesignable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didFetchUser), name: NSNotification.Name(rawValue: "didFetchUser"), object: nil)
    }
    
    @objc func didFetchUser() {
        setupInitialViews()
    }
    
    @IBAction func setLimitButtonTapped(_ sender: Any) {
        Segues.presentViewController(vc: self, name: SegueConstants.popups, id: SegueConstants.setLimit)
    }
    
    @IBAction func addFoodButtonTapped(_ sender: Any) {
        addFood()
    }
    
    func setupInitialViews() {
        guard let currentUser = UserController.shared.currentUser else { return }
        currentCaloriesLabel.text = " Current: \(currentUser.currentCalories)"
        limitLabel.text = "Limit: \(currentUser.calorieLimit)"
    }
    
    let documentID = FirebaseManager.randomFoodDocID
    
    func addFood() {
        guard let foodItem = foodTextField.text,
            let calories = caloriesTextField.text,
            let userRef = UserController.shared.currentUser?.firebaseID else { return }
        
        if let myNumber = NumberFormatter().number(from: calories) {
            let cal = myNumber.intValue
            let foodObject = Food(name: foodItem, calories: cal, userRef: userRef, firebaseID: documentID)
            FoodController.shared.createFood(food: foodObject) { (success) in
                if success {
                    self.updateUserCurrentCalories()
                }
            }
        }
    }
    
    func updateUserCurrentCalories() {
        guard let calories = caloriesTextField.text,
            let number = NumberFormatter().number(from: calories)  else { return }
        let cal = number.intValue
        UserController.shared.currentUser?.currentCalories += cal
        guard let user = UserController.shared.currentUser else { return }
        UserController.shared.createOrUpdateUser(user, firebaseID: user.firebaseID) { (success) in
            if success {
                self.currentCaloriesLabel.text = "Current: \(user.currentCalories)"
                self.emptyTextFields()
            } else {
                // display error message to the user
            }
        }
    }
    
    func emptyTextFields() {
        caloriesTextField.text = ""
        foodTextField.text = ""
    }
}


// MARK: - Extensions
extension InputViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Animations.transitionUpwards(view: inputStackView, height: 80)
        Animations.transitionUpwards(view: currentCaloriesLabel, height: 50)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Animations.transitionDownwards(view: inputStackView, height: 80)
        Animations.transitionDownwards(view: currentCaloriesLabel, height: 50)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
