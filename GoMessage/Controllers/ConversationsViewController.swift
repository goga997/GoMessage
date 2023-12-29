//
//  ViewController.swift
//  GoMessage
//
//  Created by Grigore on 28.12.2023.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
        validateAuth()
    }

    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

