//
//  HomeView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 11.03.2025.
//
//

//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//
//class HomeView: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    private var fbService = FirebaseService()
//    let db = Firestore.firestore()
//    
//    let nameLabel = UILabel()
//    let passportInfoLabel = UILabel()
//    let payNumberLabel = UILabel()
//    let tableView = UITableView()
//    let totalAmountLabel = UILabel()
//    let sberPayButton = UIButton()
//    let otherPaymentButton = UIButton()
//    
//    var meterReadings: [(String, String)] = [("Газ", "0"), ("Свет", "0"), ("Вода", "0")] // Пример данных
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        fetchUserData()
//    }
//    
//    func setupView() {
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
//        
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrollView)
//        
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(stackView)
//        
//        [nameLabel, passportInfoLabel, payNumberLabel].forEach { label in
//            stackView.addArrangedSubview(label)
//        }
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.isScrollEnabled = false
//        tableView.backgroundColor = .clear // Прозрачный фон таблицы
//        tableView.separatorColor = .black // Чёрные сепараторы
//        stackView.addArrangedSubview(tableView)
//        
//        totalAmountLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        stackView.addArrangedSubview(totalAmountLabel)
//        
//        sberPayButton.setImage(UIImage(named: "SberPayButton"), for: .normal)
//        sberPayButton.translatesAutoresizingMaskIntoConstraints = false
//        stackView.addArrangedSubview(sberPayButton)
//        
//        // Настройка кнопки "Другой способ оплаты"
//        otherPaymentButton.setTitle("Другой способ оплаты", for: .normal)
//        otherPaymentButton.setTitleColor(.black, for: .normal)
//        otherPaymentButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        otherPaymentButton.titleLabel?.underline()
//        otherPaymentButton.translatesAutoresizingMaskIntoConstraints = false
//        stackView.addArrangedSubview(otherPaymentButton)
//        
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
//            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
//            
//            tableView.heightAnchor.constraint(equalToConstant: 150), // Высота таблицы
//            sberPayButton.heightAnchor.constraint(equalToConstant: 160), // Высота кнопки
//            otherPaymentButton.heightAnchor.constraint(equalToConstant: 30) // Высота кнопки
//        ])
//    }
//    
//    func fetchUserData() {
//        guard let user = Auth.auth().currentUser else { return }
//        
//        db.collection("Users").document(user.uid).getDocument { document, error in
//            if let error = error {
//                let errorMessage = "Ошибка получения данных: \(error.localizedDescription)"
//                self.nameLabel.text = errorMessage
//                self.passportInfoLabel.text = errorMessage
//                self.payNumberLabel.text = errorMessage
//                return
//            }
//            
//            guard let document = document, document.exists else {
//                let noDataMessage = "Данные не найдены"
//                self.nameLabel.text = noDataMessage
//                self.passportInfoLabel.text = noDataMessage
//                self.payNumberLabel.text = noDataMessage
//                return
//            }
//            
//            let data = document.data()
//            
//            // Обновление данных в метках профиля
//            self.nameLabel.text = data?["Name"] as? String ?? "Не указано"
//            self.nameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
//            self.nameLabel.textAlignment = .center
//            self.nameLabel.numberOfLines = 0
//            
//            let series = data?["series"] as? String ?? "Не указано"
//            let number = data?["number"] as? String ?? "Не указано"
//            self.passportInfoLabel.text = "Серия: \(series), Номер: \(number)"
//            self.passportInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//            
//            let payNumber = data?["payNumber"] as? String ?? "Не указано"
//            self.payNumberLabel.text = "Номер лицевого счета: \(payNumber)"
//            self.payNumberLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//            
//            // Обновление показаний из Firebase
//            let gasReading = data?["gas"] as? String ?? "0"
//            let lightReading = data?["light"] as? String ?? "0"
//            let waterReading = data?["water"] as? String ?? "0"
//            
//            self.meterReadings = [("Газ", gasReading), ("Свет", lightReading), ("Вода", waterReading)]
//            
//            self.tableView.reloadData()
//            
//            self.updateTotalAmount()
//        }
//    }
//
//    
//    func updateTotalAmount() {
//        let total = meterReadings.reduce(0) { $0 + (Int($1.1) ?? 0) }
//        totalAmountLabel.text = "Итоговая сумма: \(total) ₽"
//    }
//    
//    @objc private func signOut() {
//        fbService.signOut()
//        NotificationCenter.default.post(name: Notification.Name("RootVC"), object: nil, userInfo: ["VC" : WindowCase.login])
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return meterReadings.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let reading = meterReadings[indexPath.row]
//        cell.textLabel?.text = "\(reading.0): \(reading.1) ₽"
//        cell.backgroundColor = .clear // Прозрачный фон ячейки
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium) // Увеличиваем шрифт
//        cell.selectionStyle = .none
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50 // Увеличение высоты ячейки
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let additionalSeparatorThickness: CGFloat = 1.5 // Увеличить толщину сепаратора
//        let additionalSeparator = UIView(
//            frame: CGRect(x: 0, y: cell.frame.size.height - additionalSeparatorThickness, width: cell.frame.size.width, height: additionalSeparatorThickness)
//        )
//        additionalSeparator.backgroundColor = .black
//        cell.addSubview(additionalSeparator)
//    }
//}
//
//extension UILabel {
//    func underline() {
//        guard let text = self.text else { return }
//        let textRange = NSMakeRange(0, text.count)
//        let attributedText = NSMutableAttributedString(string: text)
//        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
//        self.attributedText = attributedText
//    }
//}


import UIKit
import FirebaseAuth
import FirebaseFirestore
import KeychainAccess

class HomeView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var fbService = FirebaseService()
    private let db = Firestore.firestore()
    
    private let nameLabel = UILabel()
    private let passportInfoLabel = UILabel()
    private let payNumberLabel = UILabel()
    private let tableView = UITableView()
    private let totalAmountLabel = UILabel()
    private let sberPayButton = UIButton()
    private let otherPaymentButton = UIButton()
    
    var meterReadings: [(String, String)] = [("Газ", "0"), ("Электроэнергия", "0"), ("Водоснабжение", "0")]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUserData()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        [nameLabel, passportInfoLabel, payNumberLabel].forEach { label in
            stackView.addArrangedSubview(label)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        stackView.addArrangedSubview(tableView)
        
        totalAmountLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        stackView.addArrangedSubview(totalAmountLabel)
        
        sberPayButton.setImage(UIImage(named: "SberPayButton"), for: .normal)
        sberPayButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(sberPayButton)
        
        otherPaymentButton.setTitle("Другой способ оплаты", for: .normal)
        otherPaymentButton.setTitleColor(.black, for: .normal)
        otherPaymentButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        otherPaymentButton.titleLabel?.underline()
        otherPaymentButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(otherPaymentButton)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            tableView.heightAnchor.constraint(equalToConstant: 150),
            sberPayButton.heightAnchor.constraint(equalToConstant: 160),
            otherPaymentButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection("Users").document(user.uid).getDocument { document, error in
            if let error = error {
                self.displayError(message: "Ошибка получения данных: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                self.displayError(message: "Данные не найдены")
                return
            }
            
            let data = document.data()
            
            // Обновление данных в метках профиля
            self.nameLabel.text = data?["Name"] as? String ?? "Не указано"
            self.nameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            self.nameLabel.textAlignment = .center
            self.nameLabel.numberOfLines = 0
            
            let series = data?["series"] as? String ?? "Не указано"
            let number = data?["number"] as? String ?? "Не указано"
            self.passportInfoLabel.text = "Серия: \(series), Номер: \(number)"
            self.passportInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            
            let payNumber = data?["payNumber"] as? String ?? "Не указано"
            self.payNumberLabel.text = "Номер лицевого счета: \(payNumber)"
            self.payNumberLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            
            // Обновление показаний из Firebase
            let gasReading = data?["gas"] as? String ?? "0"
            let lightReading = data?["light"] as? String ?? "0"
            let waterReading = data?["water"] as? String ?? "0"
            
            self.meterReadings = [("Газ", gasReading), ("Электроэнергия", lightReading), ("Водоснабжение", waterReading)]
            
            self.tableView.reloadData()
            self.updateTotalAmount()
        }
    }
    
    private func displayError(message: String) {
        nameLabel.text = message
        passportInfoLabel.text = message
        payNumberLabel.text = message
    }
    
    func updateTotalAmount() {
        let total = meterReadings.reduce(0) { $0 + (Int($1.1) ?? 0) }
        totalAmountLabel.text = "Итоговая сумма: \(total) ₽"
    }
    
    @objc private func signOut() {
        fbService.signOut()
        NotificationCenter.default.post(name: Notification.Name("RootVC"), object: nil, userInfo: ["VC" : WindowCase.login])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meterReadings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let reading = meterReadings[indexPath.row]
        cell.textLabel?.text = "\(reading.0): \(reading.1) ₽"
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let additionalSeparatorThickness: CGFloat = 1.5
        let additionalSeparator = UIView(
            frame: CGRect(x: 0, y: cell.frame.size.height - additionalSeparatorThickness, width: cell.frame.size.width, height: additionalSeparatorThickness)
        )
        additionalSeparator.backgroundColor = .black
        cell.addSubview(additionalSeparator)
    }
}

extension UILabel {
    func underline() {
        guard let text = self.text else { return }
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        self.attributedText = attributedText
    }
}
