//
//  TabBarView.swift
//  JKH
//
//  Created by Дмитрий Макеев on 13.03.2025.
//

import UIKit

class TabBarView: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createHomeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        
        let homeViewController = HomeView()
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        homeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeViewController.tabBarItem.title = "Главная"
        
        let settingsViewController = SettingsView()  // Предположительно ваше другое представление
        settingsViewController.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsViewController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        settingsViewController.tabBarItem.title = "Настройки"
        
        let contactsViewController = ContactsView()  // Предположительно ваше другое представление
        contactsViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        contactsViewController.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        contactsViewController.tabBarItem.title = "Контакты"
        
        tabBarController.viewControllers = [homeViewController, settingsViewController, contactsViewController]
        
        // Кастомизация внешнего вида Tab Bar
        if let items = tabBarController.tabBar.items {
            for item in items {
                // Цвет иконок в состоянии по умолчанию
                item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                // Цвет иконок в выбранном состоянии
                item.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
            }
        }
        
        tabBarController.tabBar.layer.masksToBounds = true
        
        return tabBarController
    }
}
