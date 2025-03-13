//
//  SettingsDetailViewController.swift
//  JKH
//
//  Created by Дмитрий Макеев on 13.03.2025.
//


import UIKit

class SettingsDetailViewController: UIViewController {
    
    var details: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for detail in details {
            let label = UILabel()
            label.text = detail
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black
            stackView.addArrangedSubview(label)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
}
