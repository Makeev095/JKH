//
//  ViewController.swift
//  JKH
//
//  Created by Дмитрий Макеев on 10.03.2025.
//

import UIKit
import Firebase

struct UserData {
    let name: String
    let email: String
    let password: String
}

class RegistrationView: UIViewController {
    
    let FBService = FirebaseService()
    
    lazy var registrationLabel: UILabel = {
        $0.text = "Регистрация"
        $0.textColor = .white
        $0.font = UIFont(name: "PlayfairDisplay-BlackItalic", size: 50)
        return $0
    }(UILabel())
    
    lazy var nameTextFieldView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    lazy var emailTextFieldView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    lazy var passwordTextFieldView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    lazy var nameTextField: UITextField = {
        $0.placeholder = "Введите ваше ФИО"
        $0.font = .systemFont(ofSize: 20)
        return $0
    }(UITextField())
    
    lazy var emailTextField: UITextField = {
        $0.placeholder = "Введите ваш email"
        $0.font = .systemFont(ofSize: 20)
        return $0
    }(UITextField())
    
    lazy var passwordTextField: UITextField = {
        $0.placeholder = "Введите пароль"
        $0.font = .systemFont(ofSize: 20)
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    lazy var registrationButton: UIButton = {
        $0.setTitle("Зарегистрироваться", for: .normal)
        $0.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 25
        return $0
    }(UIButton(primaryAction: registrationButtonAction))
    
    lazy var haveAccountButton: UIButton = {
        $0.setTitle("Уже есть аккаунт", for: .normal)
        $0.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        $0.layer.cornerRadius = 14
        return $0
    }(UIButton(primaryAction: haveAccountButtonAction))
    
    lazy var registrationButtonAction = UIAction { [weak self] _ in

    }
    
    lazy var haveAccountButtonAction = UIAction { _ in
        NotificationCenter.default.post(name: Notification.Name(rawValue: "RootVC"), object: nil, userInfo: ["VC" : WindowCase.login])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    
    private func setupView() {
        
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "RegBg")
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        view.addSubview(registrationLabel)
        view.addSubview(nameTextFieldView)
        nameTextFieldView.addSubview(nameTextField)
        view.addSubview(emailTextFieldView)
        emailTextFieldView.addSubview(emailTextField)
        view.addSubview(passwordTextFieldView)
        passwordTextFieldView.addSubview(passwordTextField)
        view.addSubview(registrationButton)
        view.addSubview(haveAccountButton)
    }
    
    private func setupConstraints() {
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        haveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            registrationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 70),
            registrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextFieldView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 160),
            nameTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.centerXAnchor.constraint(equalTo: nameTextFieldView.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: nameTextFieldView.centerYAnchor),
            
            emailTextFieldView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor, constant: 20),
            emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.centerXAnchor.constraint(equalTo: emailTextFieldView.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
            
            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 20),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.centerXAnchor.constraint(equalTo: passwordTextFieldView.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            
            haveAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            haveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            haveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            haveAccountButton.heightAnchor.constraint(equalToConstant: 35),
            
            registrationButton.bottomAnchor.constraint(equalTo: haveAccountButton.topAnchor, constant: -15),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registrationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
