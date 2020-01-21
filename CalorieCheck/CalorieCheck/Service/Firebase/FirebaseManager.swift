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
    static let randomFoodDocID = db.food.document().documentID
    static let currentUser = Auth.auth().currentUser?.uid
    static var userID: String?
    
    /// Authenticates a user in the database
    static func authenticateAndCreateUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(.failure(error))
                print(FirebaseErrors.FailedCreation)
            } else {
                guard let newUserID = user?.user.uid else { return }
                userID = newUserID
                completion(.success(true))
            }
        }
    }
    
    static func signUserOutOfAuthentication() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            print("Signed out!")
        }
    }
    
    static func signInAuthentication(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if result?.user == nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    /// Adds a state listener for user login. Returns a user if user is logged in.
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

// MARK: - Food Methods
extension FirebaseManager {
    static func createAndUpdateFoodItem(foodData: [String : Any], firebaseID: String, completion: @escaping (Bool) -> Void) {
        db.food.document(firebaseID).setData(foodData, merge: true) { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
