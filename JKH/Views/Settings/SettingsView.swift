//
//  SettingsView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 12.03.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
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
        
        let generalSection = createButton(title: "Общие настройки")
        let notificationsSection = createButton(title: "Уведомления")
        let privacySection = createButton(title: "Конфиденциальность")
        let accountSection = createButton(title: "Аккаунт")
        
        generalSection.addTarget(self, action: #selector(openGeneralSettings), for: .touchUpInside)
        notificationsSection.addTarget(self, action: #selector(openNotificationsSettings), for: .touchUpInside)
        privacySection.addTarget(self, action: #selector(openPrivacySettings), for: .touchUpInside)
        accountSection.addTarget(self, action: #selector(openAccountSettings), for: .touchUpInside)
        
        stackView.addArrangedSubview(generalSection)
        stackView.addArrangedSubview(notificationsSection)
        stackView.addArrangedSubview(privacySection)
        stackView.addArrangedSubview(accountSection)
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }
    
    @objc private func openGeneralSettings() {
        let detailVC = SettingsDetailViewController()
        detailVC.title = "Общие настройки"
        detailVC.details = ["Язык: Русский", "Тема: Светлая"]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc private func openNotificationsSettings() {
        let detailVC = SettingsDetailViewController()
        detailVC.title = "Уведомления"
        detailVC.details = ["Звук: Включен", "Email: Включен"]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc private func openPrivacySettings() {
        let detailVC = SettingsDetailViewController()
        detailVC.title = "Конфиденциальность"
        detailVC.details = ["Расположение: Выключено", "История: Включено"]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc private func openAccountSettings() {
        let detailVC = AccountSettingsViewController() // используй отдельный контроллер для аккаунта
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
