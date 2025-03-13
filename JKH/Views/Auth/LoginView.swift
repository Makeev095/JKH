//
//  LoginView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 10.03.2025.
//

import UIKit
import Lottie

class LoginView: UIViewController {
    
    private var fbService = FirebaseService()
    
    private let loadingAnimation = LottieAnimationView(name: "LoadingAnimation")
    
    lazy var authLabel: UILabel = {
        $0.text = "Авторизация"
        $0.textColor = .white
        $0.font = UIFont(name: "PlayfairDisplay-BlackItalic", size: 50)
        return $0
    }(UILabel())
    
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
    
    lazy var emailTextField: UITextField = {
        $0.placeholder = "Введите email"
        $0.font = .systemFont(ofSize: 20)
        return $0
    }(UITextField())
    
    lazy var passwordTextField: UITextField = {
        $0.placeholder = "Введите пароль"
        $0.isSecureTextEntry = true
        $0.font = .systemFont(ofSize: 20)
        return $0
    }(UITextField())
    
    lazy var authButton: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 25
        return $0
    }(UIButton(primaryAction: authButtonAction))
    
    lazy var registrationButton: UIButton = {
        $0.setTitle("Зарегистрироваться", for: .normal)
        $0.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        $0.layer.cornerRadius = 14
        return $0
    }(UIButton(primaryAction: registrationButtonAction))
    
    lazy var authButtonAction = UIAction { [weak self] _ in
        
        guard let self = self else { return }
        
        loadingAnimation.isHidden = false
        authButton.setTitle("", for: .normal)
        loadingAnimation.loopMode = .loop
        loadingAnimation.play()
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let user = UserData(name: nil, email: email, password: password)
        
        fbService.authUser(user: user) { [weak self] isLogin in
            
            guard let self = self else { return }
            
            if isLogin {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "RootVC"), object: nil, userInfo: ["VC" : WindowCase.home])
                
                loadingAnimation.stop()
                loadingAnimation.isHidden = true
            } else {
                print("Не вошел")
            }
        }
        
 

    }
    
    lazy var registrationButtonAction = UIAction { _ in
        NotificationCenter.default.post(name: Notification.Name(rawValue: "RootVC"), object: nil, userInfo: ["VC" : WindowCase.reg])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    
    private func setupView() {
        
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "AuthBg")
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        loadingAnimation.isHidden = true
        
        view.addSubview(authLabel)
        view.addSubview(emailTextFieldView)
        emailTextFieldView.addSubview(emailTextField)
        view.addSubview(passwordTextFieldView)
        passwordTextFieldView.addSubview(passwordTextField)
        view.addSubview(authButton)
        view.addSubview(registrationButton)
        view.addSubview(loadingAnimation)
    }
    
    private func setupConstraints() {
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        authButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        loadingAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            authLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 70),
            authLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextFieldView.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 160),
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
            
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            registrationButton.heightAnchor.constraint(equalToConstant: 35),
            
            authButton.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -15),
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            authButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingAnimation.centerXAnchor.constraint(equalTo: authButton.centerXAnchor),
            loadingAnimation.centerYAnchor.constraint(equalTo: authButton.centerYAnchor),
            loadingAnimation.widthAnchor.constraint(equalToConstant: 50),
            loadingAnimation.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
