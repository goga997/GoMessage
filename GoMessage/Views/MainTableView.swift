//
//  MainTableView.swift
//  GoMessage
//
//  Created by Grigore on 29.12.2023.
//

import UIKit

class MainTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
        setDelegates()
        register(ChatCell.self, forCellReuseIdentifier: ChatCell.idTableViewCell)
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
    
}

//DATA SOURCE
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.idTableViewCell, for: indexPath) as? ChatCell else { return UITableViewCell() }
        
        return cell
    }
}

//DELEGATE
extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
