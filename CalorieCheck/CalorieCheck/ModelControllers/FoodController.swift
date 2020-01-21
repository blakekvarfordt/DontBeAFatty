//
//  FoodController.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/20/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation

class FoodController {
    static let shared = FoodController()
    
    func createAndUpdateFood(food: Food, firebaseID: String, completion: @escaping (Bool) -> Void) {
        guard let jsonData = Food.encode(object: food) else { return }
        FirebaseManager.createAndUpdateFoodItem(foodData: jsonData, firebaseID: firebaseID) { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
