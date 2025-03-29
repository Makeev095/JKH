//
//  MeterReadingViewController.swift
//  JKH
//
//  Created by Дмитрий Макеев on 13.03.2025.
//
//

import UIKit

class MeterReadingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private let addressPicker = UIPickerView()
    private let addresses = ["Булгакова 2", "Булгакова 3", "Булгакова 5"]
    private var selectedAddress: String?
    
    private let waterMeterField = UITextField()
    private let gasMeterField = UITextField()
    
    private let apiKey = "AIzaSyAgeyOfTclNchMDy4SauNXqngCIvQywySQ" // Замените на ваш API-ключ
    private let spreadsheetId = "173LJSu22SZltMdg-X-2p30iOeAh5qFzTCx-SzrUjJo4" // Замените на ID вашей таблицы
    private let range = "Sheet1!A1"


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
        
        addressPicker.delegate = self
        addressPicker.dataSource = self
        addressPicker.translatesAutoresizingMaskIntoConstraints = false
        addressPicker.layer.cornerRadius = 10
        addressPicker.backgroundColor = .white
        addressPicker.layer.shadowColor = UIColor.black.cgColor
        addressPicker.layer.shadowOffset = CGSize(width: 0, height: 5)
        addressPicker.layer.shadowRadius = 10
        addressPicker.layer.shadowOpacity = 0.3
        
        waterMeterField.placeholder = "Введите показания воды"
        styleField(waterMeterField)
        
        gasMeterField.placeholder = "Введите показания газа"
        styleField(gasMeterField)
        
        stackView.addArrangedSubview(wrapInContainer(view: addressPicker))
        stackView.addArrangedSubview(wrapInContainer(view: waterMeterField))
        stackView.addArrangedSubview(wrapInContainer(view: gasMeterField))
        stackView.addArrangedSubview(createSubmitButton())
    }
    
    private func styleField(_ textField: UITextField) {
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 5)
        textField.layer.shadowRadius = 10
        textField.layer.shadowOpacity = 0.3
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func wrapInContainer(view: UIView) -> UIView {
        let container = UIView()
        container.layer.cornerRadius = 10
        container.backgroundColor = .white
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 5)
        container.layer.shadowRadius = 10
        container.layer.shadowOpacity = 0.3
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15)
        ])
        
        return container
    }
    
    private func createSubmitButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(submitReadings), for: .touchUpInside)
        return button
    }
    
    @objc private func submitReadings() {
        guard let selectedAddress = selectedAddress else {
            print("Адрес не выбран")
            return
        }
        
        guard let waterReading = waterMeterField.text, !waterReading.isEmpty,
              let gasReading = gasMeterField.text, !gasReading.isEmpty else {
            print("Показания не введены")
            return
        }
        
        uploadReadingsToGoogleSheets(water: waterReading, gas: gasReading)
    }

    private func uploadReadingsToGoogleSheets(water: String, gas: String) {
        guard let url = URL(string: "https://sheets.googleapis.com/v4/spreadsheets/\(spreadsheetId)/values/\(range):append?valueInputOption=USER_ENTERED&key=\(apiKey)") else {
            return
        }

        let body: [String: Any] = [
            "values": [
                [selectedAddress ?? "Неизвестный адрес", water, gas, Date().description] // Строка значений
            ]
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Не удалось преобразовать тело в JSON")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка при отправке данных в Google Sheets: $$error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Неверный ответ от сервера")
                return
            }
            
            print("Данные успешно отправлены в Google Sheets")
        }
        
        task.resume()
    }
    
    // MARK: - UIPickerViewDelegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addresses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addresses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAddress = addresses[row]
    }
}
