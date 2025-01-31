//
//  User.swift
//  BibiDAcier
//
//  Created by neoxia on 31/01/2025.
//

import Foundation

struct User: Codable {
    var name: String
    var firsName: String
    var age: Int
    var height: Int
    var profilePicture: String
    var weight: Int
}


import FirebaseAuth
import FirebaseFirestore

class UserService {
    let db = Firestore.firestore()
    
    func addUser(user: User, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Utilisateur non connecté"]))
            return
        }
        
        do {
            let userData = try JSONEncoder().encode(user)
            let dictionary = try JSONSerialization.jsonObject(with: userData, options: .fragmentsAllowed) as [String: Any]
            
            db.collection("User").document(userID).setData(dictionary ?? [:]) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
    
}
