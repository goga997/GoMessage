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
        view.addSubview(createHeader() ?? UIView())
    }
    
    @objc private func didTapLogOut() {
        let alert = UIAlertController(title: "", message: "Are you sure you want to Log Out ?", preferredStyle: .actionSheet)
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
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func createHeader() -> UIView? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else { return nil }
        
        let safeEmail = DataBaseManager.safeEmail(emailAdress: email)
        let fileName = safeEmail + "_profile_picture.png"
        let path = "images/" + fileName
        let headerView = UIView(frame: CGRect(x: 0, y: 100, width: self.view.width, height: 200))
        headerView.backgroundColor = .link
        
        let imageView = UIImageView(frame: CGRect(x: (headerView.width - 100) / 2, y: 50, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = imageView.width / 2
        imageView.layer.masksToBounds = true
        
        headerView.addSubview(imageView)
        
        StorageManager.shared.downloadURL(for: path) { [weak self] result in
            switch result {
            case .success(let url):
                self?.downloadImage(imageView: imageView, url: url)
            case .failure(let error):
                print("Failled to get download url \(error)")
            }
        }
        return headerView
    }
    
    func downloadImage(imageView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }
        .resume()
    }
}
