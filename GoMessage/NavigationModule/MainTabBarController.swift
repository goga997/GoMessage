//
//  MainTabBarController.swift
//  GoMessage
//
//  Created by Grigore on 29.12.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()

        let firstVC = ConversationsViewController()
        let secondVC = ProfileViewController()
        
        firstVC.title = "Chats"; secondVC.title = "Profile";
        
        firstVC.navigationItem.largeTitleDisplayMode = .always
        secondVC.navigationItem.largeTitleDisplayMode = .always
        
        //-------------------------------------------------------------------------------------------
        let navController1 = UINavigationController(rootViewController: firstVC)
        let navController2 = UINavigationController(rootViewController: secondVC)
        
        navController1.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "house"), tag: 1)
        navController2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        navController1.navigationBar.prefersLargeTitles = true
        navController2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navController1, navController2], animated: true)
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .black
//        tabBar.layer.borderWidth = 2
//        tabBar.layer.borderColor = UIColor.black.cgColor
    }
}
