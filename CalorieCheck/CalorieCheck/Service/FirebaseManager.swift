//
//  FirebaseManager.swift
//  CalorieCheck
//
//  Created by Blake kvarfordt on 1/11/20.
//  Copyright © 2020 Blake kvarfordt. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct FirebaseManager {
    
    private static let db = Firestore.firestore()
    
    /// Create user
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
}
