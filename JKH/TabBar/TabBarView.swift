//
//  TabBarView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 13.03.2025.

import UIKit

class TabBarView: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarAppearance()
        viewControllers = createHomeTabBarController()
    }
    
    private func configureTabBarAppearance() {
        tabBar.backgroundColor = .white // Установка цвета фона
        tabBar.isTranslucent = false
        
        if let items = tabBar.items {
            for item in items {
                item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                item.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
            }
        }
    }
    
    func createHomeTabBarController() -> [UIViewController] {
        let homeViewController = HomeView()
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        homeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeViewController.tabBarItem.title = "Главная"
        
        let settingsViewController = SettingsViewController()
        let settingsNavController = UINavigationController(rootViewController: settingsViewController)
        settingsNavController.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsNavController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        settingsNavController.tabBarItem.title = "Настройки"
        
        let contactsViewController = ContactsView()
        let contactsNavController = UINavigationController(rootViewController: contactsViewController)
        contactsNavController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        contactsNavController.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        contactsNavController.tabBarItem.title = "Контакты"
        
        let meterReadingViewController = MeterReadingViewController()
//        let meterReadingViewController = UINavigationController(rootViewController: meterReadingViewController)
        meterReadingViewController.tabBarItem.image = UIImage(systemName: "gauge.with.dots.needle.33percent")
        meterReadingViewController.tabBarItem.selectedImage = UIImage(systemName: "gauge.with.dots.needle.67percent")
        meterReadingViewController.tabBarItem.title = "Подать показания"
        
        return [homeViewController, settingsNavController, contactsNavController, meterReadingViewController]
    }
}
