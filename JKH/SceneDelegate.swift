//
//  SceneDelegate.swift
//  JKH
//
//  Created by Дмитрий Макеев on 10.03.2025.
//

import UIKit

enum WindowCase {
    case login, reg, home
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let fbService = FirebaseService()
    private let tabBar = TabBarView()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(rootVC), name: Notification.Name(rawValue: "RootVC"), object: nil)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        if fbService.isLogin() {
            window?.rootViewController = windowManager(vc: .home)
        } else {
            window?.rootViewController = windowManager(vc: .reg)
        }
        window?.makeKeyAndVisible()
    }
    
    private func windowManager(vc: WindowCase) -> UIViewController {
        switch vc {
        case .login:
            return LoginView()
        case .reg:
            return RegistrationView()
        case .home:
            return tabBar.createHomeTabBarController()
//            return HomeView()
        }
    }
    
    @objc func rootVC(notification: Notification) {
        guard let userInfo = notification.userInfo, let vc = userInfo["VC"] as? WindowCase else { return }
        self.window?.rootViewController = windowManager(vc: vc)
    }
}
