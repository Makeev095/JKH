//
//  HomeView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 11.03.2025.
//

//import UIKit
//import FirebaseAuth
//
//class HomeView: UIViewController {
//    
//    private var fbService = FirebaseService()
//    
//    lazy var signOutButton: UIButton = {
//        $0.setTitle("Выйти", for: .normal)
//        return $0
//    }(UIButton(primaryAction: signOutAction))
//    
//    lazy var signOutAction: UIAction = UIAction { [weak self] _ in
//        guard let self = self else { return }
//            fbService.signOut()
//            NotificationCenter.default.post(name: Notification.Name("RootVC"), object: nil, userInfo: ["VC" : WindowCase.login])
//    }
//    
//    override func viewDidLoad() {
//        setupView()
//        setupConstraints()
//    }
//    
//    func setupView() {
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
//        
////        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
////        backgroundImageView.image = UIImage(named: "HomeBg")
////        backgroundImageView.contentMode = .scaleAspectFill
////        self.view.insertSubview(backgroundImageView, at: 0)
//        
////        view.addSubview(signOutButton)
//    }
//    
//    func setupConstraints() {
//        signOutButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
////            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
////            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
////            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
////            signOutButton.heightAnchor.constraint(equalToConstant: 50)
//            
//            
//        ])
//    }
//}


import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeView: UIViewController {
    
    private var fbService = FirebaseService()
    let db = Firestore.firestore()
    
    // UI Elements
    lazy var signOutButton: UIButton = {
        $0.setTitle("Выйти", for: .normal)
        return $0
    }(UIButton(primaryAction: signOutAction))
    
    lazy var signOutAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        fbService.signOut()
        NotificationCenter.default.post(name: Notification.Name("RootVC"), object: nil, userInfo: ["VC" : WindowCase.login])
    }
    
    let nameLabel = UILabel()
    let passportInfoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        fetchUserData()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        view.addSubview(signOutButton)
        view.addSubview(nameLabel)
        view.addSubview(passportInfoLabel)
    }
    
    func setupConstraints() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        passportInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passportInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            passportInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passportInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else { return }
        
        // Получение имени пользователя из FirebaseAuth
        nameLabel.text = "Имя пользователя: \(user.displayName ?? "Неизвестно")"
        
        // Получение данных из Firestore
        db.collection("Users").document(user.uid).getDocument { document, error in
            if let error = error {
                self.passportInfoLabel.text = "Ошибка получения данных: \(error.localizedDescription)"
                return
            }
            
            guard let document = document, document.exists else {
                self.passportInfoLabel.text = "Данные не найдены"
                return
            }
            
            let data = document.data()
            let series = data?["series"] as? String ?? "Не указано"
            let number = data?["number"] as? String ?? "Не указано"
            
            self.passportInfoLabel.text = "Серия: \(series), Номер: \(number)"
        }
    }
}

