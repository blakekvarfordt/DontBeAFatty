//
//  FirebaseManager.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct FirebaseManager {
    
    /// Database
    private static let db = Firestore.firestore()
    
    /// Authenticates a user in the database
    static func authenticateAndCreateUser(email: String, password: String, userData: [String : Any], firebaseID: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(.failure(error))
                print(FirebaseErrors.FailedCreation)
            } else {
                completion(.success(true))
            }
        }
    }
    
    static func addStateListener(vc: UIViewController, completion:
        @escaping (Bool) -> ()) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    /// Creates a User collection with things NOT pertaining to login info
    static func createUser(userData: [String : Any], firebaseID: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        db.users.document(firebaseID).setData(userData, merge: true) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    /// Fetches the user from firebase
    static func fetchUser(uid: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        db.users.document(uid).getDocument { (document, error) in
            if let doc = document?.data(), document?.exists ?? false {
                completion(.success(doc))
            } else {
                completion(.failure(FirebaseErrors.NoData))
            }
        }
    }
    
    static func deleteUser(uid: String, completion: @escaping (Bool) -> Void) {
        db.users.document(uid).delete() { err in
            if let err = err {
                print(err)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
