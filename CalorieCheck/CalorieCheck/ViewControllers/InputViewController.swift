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
    @IBOutlet weak var caloriesLeftLabel: UILabel!
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
        caloriesLeftLabel.text = " Current: \(currentUser.currentCalories)"
        limitLabel.text = "Limit: \(currentUser.calorieLimit)"
    }
    
    func addFood() {
        guard let foodItem = foodTextField.text,
            let calories = caloriesTextField.text,
            let userRef = UserController.shared.currentUser?.firebaseID else { return }
        
        if let myNumber = NumberFormatter().number(from: calories) {
            let cal = myNumber.intValue
            let foodObject = Food(name: foodItem, calories: cal, userRef: userRef, firebaseID: FirebaseManager.randomFoodDocID)
        }
    }
}


// MARK: - Extensions
extension InputViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Animations.transitionUpwards(view: inputStackView, height: 80)
        Animations.transitionUpwards(view: caloriesLeftLabel, height: 50)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Animations.transitionDownwards(view: inputStackView, height: 80)
        Animations.transitionDownwards(view: caloriesLeftLabel, height: 50)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
