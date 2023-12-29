//
//  ChatCell.swift
//  GoMessage
//
//  Created by Grigore on 29.12.2023.
//

import UIKit

class ChatCell: UITableViewCell {
            
    static let idTableViewCell = "idTableViewCell"
    
    private let backgroundCell: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImageCell: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Surname"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - INITIALIZATION
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //SETUP VIEW
    private func setUpViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(backgroundCell)
        backgroundCell.addSubview(backgroundImageCell)
        backgroundImageCell.addSubview(workoutImageView)
        backgroundCell.addSubview(workoutNameLabel)
        
    }
    
}

//MARK: - CONSTRAINTS

extension ChatCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backgroundImageCell.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            backgroundImageCell.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            backgroundImageCell.heightAnchor.constraint(equalToConstant: 52),
            backgroundImageCell.widthAnchor.constraint(equalToConstant: 52),
            
            workoutImageView.topAnchor.constraint(equalTo: backgroundImageCell.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: backgroundImageCell.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: backgroundImageCell.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: backgroundImageCell.bottomAnchor, constant: -10),
            
            workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            workoutNameLabel.leadingAnchor.constraint(equalTo: backgroundImageCell.trailingAnchor, constant: 20),
            workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            
        ])
    }
}
