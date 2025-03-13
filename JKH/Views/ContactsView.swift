//
//  ContactsView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 13.03.2025.
//

import UIKit

class ContactsView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        // Основные настройки представления
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        // Создаем UIScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Создаем UIStackView и добавляем в UIScrollView
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        // Установка ограничений для UIScrollView
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
        
        // Добавление логотипа
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo1")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // Добавление секций
        let phoneSection = createInfoSection(title: "Номера телефонов", details: ["Офис: +7(8793) 38-15-80", "Аварийная служба (Круглосуточно): +7 (928) 825-61-86"])
        let emailSection = createInfoSection(title: "Email", details: ["uk.cheremushki@gmail.com"])
        let addressSection = createInfoSection(title: "Адрес", details: ["г. Москва, ул. Пушкина, д. 19"])
        
        let hoursDetails = [
            "Понедельник: 9:00 - 17:00",
            "Вторник: 9:00 - 19:00",
            "Среда: 9:00 - 17:00",
            "Четверг: 9:00 - 17:00",
            "Пятница: 9:00 - 16:00",
            "",
            "Суббота: Выходной",
            "Воскресенье: Выходной",
            "",
            "Перерыв: 12:00 - 13:00"
        ]
        let hoursSection = createInfoSection(title: "Часы работы", details: hoursDetails)
        
        let visitingHoursSection = createInfoSection(title: "Приемные часы", details: ["Вторник 16:00 - 19:00"])
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(phoneSection)
        stackView.addArrangedSubview(emailSection)
        stackView.addArrangedSubview(addressSection)
        stackView.addArrangedSubview(hoursSection)
        stackView.addArrangedSubview(visitingHoursSection)
    }
    
    private func createInfoSection(title: String, details: [String]) -> UIView {
        let sectionView = UIView()
        sectionView.backgroundColor = .white
        sectionView.layer.cornerRadius = 10
        sectionView.layer.shadowColor = UIColor.black.cgColor
        sectionView.layer.shadowOffset = CGSize(width: 0, height: 5)
        sectionView.layer.shadowRadius = 10
        sectionView.layer.shadowOpacity = 0.3
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let detailsStackView = UIStackView()
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 5
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for detail in details {
            let detailLabel = UILabel()
            detailLabel.text = detail
            detailLabel.font = UIFont.systemFont(ofSize: 16)
            detailLabel.textColor = .darkGray
            detailLabel.numberOfLines = 0
            detailsStackView.addArrangedSubview(detailLabel)
        }
        
        sectionView.addSubview(titleLabel)
        sectionView.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -15),
            
            detailsStackView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 15),
            detailsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            detailsStackView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -15),
            detailsStackView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: -15)
        ])
        
        return sectionView
    }
}
