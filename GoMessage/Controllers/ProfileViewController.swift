//
//  ProfileViewController.swift
//  GoMessage
//
//  Created by Grigore on 28.12.2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapLogOut))
    }
    
    @objc private func didTapLogOut() {
        
        let alert = UIAlertController(title: "", message: "Are you sure you want to Log Out ?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            do {
               try FirebaseAuth.Auth.auth().signOut()
                
                let loginVC = LoginViewController()
                let nav = UINavigationController(rootViewController: loginVC)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
            } catch {
                print("Failed to log out")
            }
        }))
        
        present(alert, animated: true)

        
    }
}
