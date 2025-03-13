//
//  SettingsView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 12.03.2025.
//

import UIKit

class SettingsView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        // Установка основного фона
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        // Создаём секции настроек
        let accountSection = createSectionView(
            withTitle: "Аккаунт",
            backgroundColor: UIColor(red: 0.93, green: 0.33, blue: 0.23, alpha: 1.0),
            iconName: "person.crop.circle.fill"
        )
        
        let notificationsSection = createSectionView(
            withTitle: "Уведомления",
            backgroundColor: UIColor(red: 0.00, green: 0.47, blue: 0.95, alpha: 1.0),
            iconName: "bell.circle.fill"
        )
        
        let privacySection = createSectionView(
            withTitle: "Политика конфиденциальности",
            backgroundColor: UIColor(red: 0.56, green: 0.73, blue: 0.57, alpha: 1.0),
            iconName: "lock.circle.fill"
        )
        
        let generalSection = createSectionView(
            withTitle: "Общие",
            backgroundColor: UIColor(red: 0.94, green: 0.77, blue: 0.15, alpha: 1.0),
            iconName: "gear.circle.fill"
        )
        
        // Настройка плавающей кнопки "Сохранить"
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Сохранить изменения", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = UIColor(red: 0.30, green: 0.60, blue: 0.85, alpha: 1.0)
        saveButton.layer.cornerRadius = 25
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        saveButton.layer.shadowRadius = 10
        saveButton.layer.shadowOpacity = 0.3
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление всех элементов в StackView для компоновки
        let stackView = UIStackView(arrangedSubviews: [accountSection, notificationsSection, privacySection, generalSection, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Установка ограничения StackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50)  // Высота кнопки "Сохранить"
        ])
    }
    
    private func createSectionView(withTitle title: String, backgroundColor: UIColor, iconName: String) -> UIView {
        let sectionView = UIView()
        sectionView.backgroundColor = backgroundColor
        sectionView.layer.cornerRadius = 10
        sectionView.layer.shadowColor = UIColor.black.cgColor
        sectionView.layer.shadowOffset = CGSize(width: 0, height: 5)
        sectionView.layer.shadowRadius = 10
        sectionView.layer.shadowOpacity = 0.3
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Иконка и заголовок для секции
        let imageView = UIImageView(image: UIImage(systemName: iconName))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление иконки и заголовка в секцию
        sectionView.addSubview(imageView)
        sectionView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
            imageView.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -15),
            sectionView.heightAnchor.constraint(equalToConstant: 60)  // Высота секции
        ])
        
        return sectionView
    }
}
