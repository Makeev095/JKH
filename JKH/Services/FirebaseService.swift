//
//  FirebaseService.swift
//  JKH
//
//  Created by Дмитрий Макеев on 10.03.2025.
//

//import Firebase
//import FirebaseAuth
//
//class FirebaseService {
//    
//    func regUser(user: UserData, completion: @escaping (Bool) -> Void) {
//        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
//            
//            guard let self = self else { return }
//            
//            guard error == nil else {
//                print(error!)
//                completion(false)
//                return
//            }
//            
//            let uid = result?.user.uid
//            setUserData(name: user.name, uid: uid!)
//            completion(true)
//        }
//    }
//    
//    private func setUserData(name: String?, uid: String) {
//        Firestore.firestore()
//            .collection("Users")
//            .document(uid)
//            .setData(["Name": name ?? ""])
//    }
//    
//    func authUser(user: UserData, completion: @escaping (Bool) -> Void) {
//        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] result, error in
//            
//            guard let self = self else { return }
//            
//            guard error == nil else {
//                print(error!)
//                completion(false)
//                return
//            }
//            
//            guard let _ = result?.user.uid else {
//                completion(false)
//                return
//            }
//            
//            completion(true)
//        }
//    }

import Firebase
import FirebaseAuth
import CryptoSwift

class FirebaseService {
    
    private let secureStore = SecureStore()
       
       private func encrypt(data: String) -> String? {
           guard let key = secureStore.getEncryptionKey() else {
               print("Ключ шифрования не найден")
               return nil
           }
           
           do {
               let aes = try AES(key: Array(key.utf8), blockMode: ECB(), padding: .pkcs7)
               let encrypted = try aes.encrypt(Array(data.utf8))
               return encrypted.toBase64()
           } catch {
               print("Error encrypting data: \(error.localizedDescription)")
               return nil
           }
       }

       func regUser(user: UserData, completion: @escaping (Bool) -> Void) {
           guard let encryptedPassword = encrypt(data: user.password) else {
               completion(false)
               return
           }
           
           Auth.auth().createUser(withEmail: user.email, password: encryptedPassword) { [weak self] result, error in
               
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
       
       func authUser(user: UserData, completion: @escaping (Bool) -> Void) {
           guard let encryptedPassword = encrypt(data: user.password) else {
               completion(false)
               return
           }
           
           Auth.auth().signIn(withEmail: user.email, password: encryptedPassword) { [weak self] result, error in
               
               guard let self = self else { return }
               
               guard error == nil else {
                   print(error!)
                   completion(false)
                   return
               }
               
               guard let _ = result?.user.uid else {
                   completion(false)
                   return
               }
               
               completion(true)
           }
       }
    
//    private let encryptionKey = "32symbolsLongKeyForEncryption!" // 32-байтный ключ для AES
//
//    private func encrypt(data: String) -> String? {
//        do {
//            let aes = try AES(key: Array(encryptionKey.utf8), blockMode: ECB(), padding: .pkcs7)
//            let encrypted = try aes.encrypt(Array(data.utf8))
//            return encrypted.toBase64()
//        } catch {
//            print("Error encrypting data: $$error.localizedDescription)")
//            return nil
//        }
//    }
//
//    func regUser(user: UserData, completion: @escaping (Bool) -> Void) {
//        guard let encryptedPassword = encrypt(data: user.password) else {
//            completion(false)
//            return
//        }
//        
//        Auth.auth().createUser(withEmail: user.email, password: encryptedPassword) { [weak self] result, error in
//            
//            guard let self = self else { return }
//            
//            guard error == nil else {
//                print(error!)
//                completion(false)
//                return
//            }
//            
//            let uid = result?.user.uid
//            setUserData(name: user.name, uid: uid!)
//            completion(true)
//        }
//    }
//    
    private func setUserData(name: String?, uid: String) {
        Firestore.firestore()
            .collection("Users")
            .document(uid)
            .setData(["Name": name ?? ""])
    }
//    
//    func authUser(user: UserData, completion: @escaping (Bool) -> Void) {
//        guard let encryptedPassword = encrypt(data: user.password) else {
//            completion(false)
//            return
//        }
//        
//        Auth.auth().signIn(withEmail: user.email, password: encryptedPassword) { [weak self] result, error in
//            
//            guard let self = self else { return }
//            
//            guard error == nil else {
//                print(error!)
//                completion(false)
//                return
//            }
//            
//            guard let _ = result?.user.uid else {
//                completion(false)
//                return
//            }
//            
//            completion(true)
//        }
//    }
    
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
    
    func getCurrentUserName(completion: @escaping (String?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        Firestore.firestore().collection("Users").document(uid).getDocument { document, error in
            if let error = error {
                print("Error fetching user: \(error)")
                completion(nil)
            } else if let document = document, document.exists {
                let name = document.data()?["Name"] as? String
                completion(name)
            } else {
                completion(nil)
            }
        }
    }
    
}


struct UserData {
    let name: String?
    let email: String
    let password: String
}
