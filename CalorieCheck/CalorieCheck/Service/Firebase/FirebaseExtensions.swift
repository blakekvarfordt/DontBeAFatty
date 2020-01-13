//
//  FirebaseExtensions.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

extension Firestore {
    var users: CollectionReference {return collection(User.FirebaseKeys.userKey)}
    var food: CollectionReference {return collection(Food.FirebaseKeys.foodKey)}
}
