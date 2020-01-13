//
//  User.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation

struct User: Codable, CodableObject {
    typealias GenericObject = User
    var name: String
    var calorieLimit: Int
    var firebaseID: String
    
    struct FirebaseKeys{
        static let userKey = "user"
        static let nameKey = "name"
        static let calorieLimitKey = "calorieLimit"
    }
}
