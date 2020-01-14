//
//  UserController.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation

class UserController {
    static let shared = UserController()
    
    var currentUser: User? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("didFetchUser"), object: nil)
        }
    }
    
    func createOrUpdateUser(_ user: User, firebaseID: String, completion: @escaping (Bool) -> Void) {
        guard let jsonString = User.encode(object: user) else {completion(false); return}
        FirebaseManager.createUser(userData: jsonString, firebaseID: firebaseID) {(result) in
            switch result {
            case .failure(let e):
                print("failed to create user: \(e.localizedDescription)")
                completion(false)
            case .success(let response):
                guard response else {completion(false); return}
                completion(true)
            }
        }
    }
    func fetchUser(uid: String, completion: @escaping (User?) -> Void) {
        FirebaseManager.fetchUser(uid: uid) { (result) in
            switch result {
            case .failure(let e):
                print(e.localizedDescription)
                completion(nil)
            case .success(let data):
                guard let user = User.decode(data: data) else {completion(nil); return}
                self.currentUser = user
                completion(user)
            }
        }
    }
    
    func deleteUser(uid: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.deleteUser(uid: uid) { (success) in
            if success {
                print("success deleting a horse document")
                completion(true)
            } else {
                print("no success deleting a document")
                completion(false)
            }
        }
    }
}
