//
//  FirebaseErrors.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation

enum FirebaseErrors: String, Error {
    case NoData = "Failure to fetch the damn data."
    case FailedUpdate = "Damn thing wont update."
    case FailedCreation = "Can't create the damn thing."
}
