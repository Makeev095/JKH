//
//  FirebaseService.swift
//  JKH
//
//  Created by Дмитрий Макеев on 10.03.2025.
//

import FirebaseAuth

class FirebaseService {
    
    func regUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
        }
    }
    
    
}
