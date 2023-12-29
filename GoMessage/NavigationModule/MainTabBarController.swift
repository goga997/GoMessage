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
        setItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .link
        tabBar.unselectedItemTintColor = .white
    }
    
    private func setItems() {
        let convsVC = ConversationsViewController()
        let profileVC = ProfileViewController()
        setViewControllers([convsVC, profileVC], animated: true)
        
        guard let items = tabBar.items else {return}
        items[0].title = "Conversations"
        items[1].title = "Profile"
        items[0].image = UIImage(systemName: "ellipsis.message.fill")
        items[1].image = UIImage(systemName: "person")
        
//        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 12) as Any], for: .normal)
    }
}
