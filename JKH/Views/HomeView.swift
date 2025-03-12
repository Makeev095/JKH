//
//  HomeView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 11.03.2025.
//

import UIKit
import FirebaseAuth

class HomeView: UIViewController {
    
    private var fbService = FirebaseService()
    
    lazy var signOutButton: UIButton = {
        $0.setTitle("Выйти", for: .normal)
        return $0
    }(UIButton(primaryAction: signOutAction))
    
    lazy var signOutAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
            fbService.signOut()
            NotificationCenter.default.post(name: Notification.Name("RootVC"), object: nil, userInfo: ["VC" : WindowCase.login])
    }
    
    override func viewDidLoad() {
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .green
        
        view.addSubview(signOutButton)
    }
    
    func setupConstraints() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
