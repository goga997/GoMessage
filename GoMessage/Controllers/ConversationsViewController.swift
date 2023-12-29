//
//  ViewController.swift
//  GoMessage
//
//  Created by Grigore on 28.12.2023.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let mainTableView = MainTableView()
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Conversations!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTapCompose))
        setDelegates()
        
        setUpView()
        setConstraints()
        fetchConversations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    @objc private func didTapCompose() {
        let newConvVC = NewConversationViewController()
        let navVC = UINavigationController(rootViewController: newConvVC)
        present(navVC, animated: true)
    }
    
    private func setDelegates() {
        mainTableView.mainTableViewDelegate = self
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    
    private func setUpView() {
        view.backgroundColor = .lightGray
        
//        mainTableView.isHidden  = true
        view.addSubview(mainTableView)
        view.addSubview(noConversationsLabel)
    }
    
    private func fetchConversations() {
        
    }
}

extension ConversationsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MainTableViewProtocol
extension ConversationsViewController: MainTableViewProtocol {
    func performPush() {
        let chatVC = ChatViewController()
        chatVC.title = "Ion Mira"
        chatVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(chatVC, animated: true)
    }
}

