//
//  SettingsView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 12.03.2025.
//




//import UIKit
//
//class SettingsView: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//    }
//    
//    private func setupView() {
//        // Основные настройки представления
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
//        
//        // Создаем UIScrollView
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrollView)
//        
//        // Создаем UIStackView и добавляем в UIScrollView
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(stackView)
//        
//        // Установка ограничений для UIScrollView
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
//            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
//        ])
//        
//        // Добавление секций настроек
//        let generalSection = createInfoSection(title: "Общие настройки", details: ["Язык: Русский", "Тема: Светлая"])
//        let notificationsSection = createInfoSection(title: "Уведомления", details: ["Звук: Включен", "Email: Включен"])
//        let privacySection = createInfoSection(title: "Конфиденциальность", details: ["Расположение: Выключено", "История: Включено"])
//        let accountSection = createInfoSection(title: "Аккаунт", details: ["Имя пользователя: user123", "Email: user@example.com"])
//        
//        stackView.addArrangedSubview(generalSection)
//        stackView.addArrangedSubview(notificationsSection)
//        stackView.addArrangedSubview(privacySection)
//        stackView.addArrangedSubview(accountSection)
//    }
//    
//    private func createInfoSection(title: String, details: [String]) -> UIView {
//        let sectionView = UIView()
//        sectionView.backgroundColor = .white
//        sectionView.layer.cornerRadius = 10
//        sectionView.layer.shadowColor = UIColor.black.cgColor
//        sectionView.layer.shadowOffset = CGSize(width: 0, height: 5)
//        sectionView.layer.shadowRadius = 10
//        sectionView.layer.shadowOpacity = 0.3
//        sectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        let titleLabel = UILabel()
//        titleLabel.text = title
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        titleLabel.textColor = .black
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        let detailsStackView = UIStackView()
//        detailsStackView.axis = .vertical
//        detailsStackView.spacing = 5
//        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        for detail in details {
//            let detailLabel = UILabel()
//            detailLabel.text = detail
//            detailLabel.font = UIFont.systemFont(ofSize: 16)
//            detailLabel.textColor = .darkGray
//            detailLabel.numberOfLines = 0
//            detailsStackView.addArrangedSubview(detailLabel)
//        }
//        
//        sectionView.addSubview(titleLabel)
//        sectionView.addSubview(detailsStackView)
//        
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
//            titleLabel.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 15),
//            titleLabel.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -15),
//            
//            detailsStackView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
//            detailsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            detailsStackView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -15),
//            detailsStackView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: -15)
//        ])
//        
//        return sectionView
//    }
//}


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
        
        // Добавление кнопок
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
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true // Изменение высоты кнопки
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
        let detailVC = SettingsDetailViewController()
        detailVC.title = "Аккаунт"
        detailVC.details = ["Имя пользователя: user123", "Email: user@example.com"]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
