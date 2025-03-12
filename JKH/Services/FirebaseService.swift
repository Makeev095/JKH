//
//  FirebaseService.swift
//  JKH
//
//  Created by Дмитрий Макеев on 10.03.2025.
//

import Firebase
import FirebaseAuth

class FirebaseService {
    
    func regUser(user: UserData, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            
            guard let self = self else { return }
            
            guard error == nil else {
                print(error!)
                completion(false)
                return
            }
            
            let uid = result?.user.uid
            setUserData(name: user.name, uid: uid!)
            completion(true)
        }
    }
    
    private func setUserData(name: String?, uid: String) {
        Firestore.firestore()
            .collection("Users")
            .document(uid)
            .setData(["Name": name ?? ""])
    }
    
    func authUser(user: UserData, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            
            guard error == nil else {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            guard let uid = result?.user.uid else {
                completion(true)
                return
            }
        }
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isLogin() -> Bool {
        if let _ = Auth.auth().currentUser {
            return true
        } else {
            return false
        }
    }
    
}


struct UserData {
    let name: String?
    let email: String
    let password: String
}
