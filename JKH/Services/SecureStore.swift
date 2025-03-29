//
//  SecureStore.swift
//  JKH
//
//  Created by Дмитрий Макеев on 29.03.2025.
//


import KeychainAccess
import CryptoSwift
import Foundation

class SecureStore {
    
    private let keychain = Keychain(service: "makey.JKH") // замените на идентификатор вашего приложения
    private let encryptionKeyIdentifier = "encryptionKey"
    
    func saveEncryptionKey() {
        let key = "32symbolsLongKeyForEncryption!" // Этот ключ должен быть секретным и соответствовать требованиям AES
        
        do {
            try keychain.set(key, key: encryptionKeyIdentifier)
        } catch let error {
            print("Ошибка при сохранении ключа в Keychain: \(error)")
        }
    }
    
    func getEncryptionKey() -> String? {
        do {
            return try keychain.get(encryptionKeyIdentifier)
        } catch let error {
            print("Ошибка при получении ключа из Keychain: \(error)")
            return nil
        }
    }
}
