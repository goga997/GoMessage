//
//  ViewController.swift
//  GoMessage
//
//  Created by Grigore on 28.12.2023.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
            let loginVC = LoginViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

