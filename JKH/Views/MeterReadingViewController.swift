//
//  MeterReadingViewController.swift
//  JKH
//
//  Created by Дмитрий Макеев on 13.03.2025.
//

import UIKit

class MeterReadingViewController: UIViewController {

    private let waterMeterField = UITextField()
    private let gasMeterField = UITextField()
    private let submitButton = UIButton(type: .system)

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
        
        // Настройка поля для воды
        waterMeterField.placeholder = "Введите показания воды"
        waterMeterField.borderStyle = .roundedRect
        styleField(waterMeterField)
        
        // Настройка поля для газа
        gasMeterField.placeholder = "Введите показания газа"
        gasMeterField.borderStyle = .roundedRect
        styleField(gasMeterField)
        
        // Настройка кнопки отправки
        submitButton.setTitle("Отправить", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitReadings), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.addArrangedSubview(createDetailView(with: waterMeterField))
        stackView.addArrangedSubview(createDetailView(with: gasMeterField))
        stackView.addArrangedSubview(submitButton)
    }

    private func styleField(_ textField: UITextField) {
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowRadius = 10
        textField.layer.shadowOpacity = 0.3
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func createDetailView(with field: UITextField) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 0.3
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(field)
        
        NSLayoutConstraint.activate([
            field.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            field.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            field.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            field.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15)
        ])
        
        return containerView
    }

    @objc private func submitReadings() {
        guard let waterReading = waterMeterField.text, !waterReading.isEmpty,
              let gasReading = gasMeterField.text, !gasReading.isEmpty else {
            // Обработать ошибку
            return
        }

        // Выполнить действия с данными
        saveReadingsToFirebase(water: waterReading, gas: gasReading)
        uploadReadingsToGoogleSheets(water: waterReading, gas: gasReading)
    }

    private func saveReadingsToFirebase(water: String, gas: String) {
        // Сохранение данных в Firebase
    }

    private func uploadReadingsToGoogleSheets(water: String, gas: String) {
        // Загрузка данных в Google Sheets
    }
}
