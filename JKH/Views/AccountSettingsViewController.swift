//
//  AccountSettingsViewController.swift
//  JKH
//
//  Created by Дмитрий Макеев on 13.03.2025.
//


import UIKit

class AccountSettingsViewController: UIViewController {

    private var fbService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        let detailView1 = createDetailView(text: "Имя пользователя: user123")
        let detailView2 = createDetailView(text: "Email: user@example.com")
        let signOutButton = createSignOutButton()
        
        stackView.addArrangedSubview(detailView1)
        stackView.addArrangedSubview(detailView2)
        stackView.addArrangedSubview(signOutButton)
    }
    
    private func createDetailView(text: String) -> UIView {
        let sectionView = UIView()
        sectionView.backgroundColor = .white
        sectionView.layer.cornerRadius = 10
        sectionView.layer.shadowColor = UIColor.black.cgColor
        sectionView.layer.shadowOffset = CGSize(width: 0, height: 5)
        sectionView.layer.shadowRadius = 10
        sectionView.layer.shadowOpacity = 0.3
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        sectionView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
            label.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -15),
            label.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: -15)
        ])
        
        return sectionView
    }

    private func createSignOutButton() -> UIButton {
        let button = UIButton(type: .system, primaryAction: signOutAction)
        button.setTitle("Выйти", for: .normal)
        button.backgroundColor = UIColor(red: 176, green: 0, blue: 0, alpha: 0.7)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    private lazy var signOutAction: UIAction = {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            fbService.signOut()
            NotificationCenter.default.post(name: Notification.Name("RootVC"), object: nil, userInfo: ["VC" : WindowCase.login])
        }
    }()
}
