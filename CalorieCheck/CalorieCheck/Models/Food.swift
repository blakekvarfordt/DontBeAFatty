//
//  Food.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation

struct Food: Codable, CodableObject {
    typealias GenericObject = Food
    var name: String
    var calories: Int
    var userRef: String
    var firebaseID: String
    
    
    struct FirebaseKeys {
        static let foodKey = "food"
        static let nameKey = "name"
        static let caloriesKey = "calories"
        static let userRefKey = "userRef"
    }
}
