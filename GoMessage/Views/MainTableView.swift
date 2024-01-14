//
//  MainTableView.swift
//  GoMessage
//
//  Created by Grigore on 29.12.2023.
//

import UIKit

protocol MainTableViewProtocol: AnyObject {
    func performPush(model: Conversation)
}

class MainTableView: UITableView {
    
    private var conversations = [Conversation]()
    
    weak var mainTableViewDelegate: MainTableViewProtocol?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
        setDelegates()
        register(ChatCell.self, forCellReuseIdentifier: ChatCell.idTableViewCell)
        startListeningForConversations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .none
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        self.delegate = self
        self.dataSource = self
    }
    
    private func startListeningForConversations() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else { return }
        
        print("starting conversation fetch...")
        
        let safeEmail = DataBaseManager.safeEmail(emailAdress: email)
        DataBaseManager.shared.getAllConversations(for: safeEmail) { [weak self] result in
            switch result {
            case .success(let conversations):
                print("successfully got conversation models")
                guard !conversations.isEmpty else { return }
                self?.conversations = conversations
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            case .failure(let error):
                print("failled to get conversations \(error)")
            }
        }
    }
}

//DATA SOURCE
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = conversations[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.idTableViewCell, for: indexPath) as? ChatCell else {
            return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }
}

//DELEGATE
extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = conversations[indexPath.row]
        
        mainTableViewDelegate?.performPush(model: model)
    }
}
