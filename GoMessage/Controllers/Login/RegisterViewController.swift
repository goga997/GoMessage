//
//  RegisterViewController.swift
//  GoMessage
//
//  Created by Grigore on 28.12.2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.clipsToBounds = true
        return scroll
    }()
    
    private let profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "person.circle")
        imgView.tintColor = .gray
        imgView.contentMode = .scaleAspectFit
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.placeholder = "Email Adress"
        //Left ViewBuffer
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.placeholder = "First Name"
        //Left ViewBuffer
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.placeholder = "Last Name"
        //Left ViewBuffer
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black .cgColor
        field.placeholder = "Password"
        //Left ViewBuffer
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        registerButton.addTarget(self, action: #selector(didRegisterTapped), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add Views
        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        profileImageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        profileImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width / 2
        
        profileImageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                     y: 40,
                                     width: size, height: size)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
        firstNameField.frame = CGRect(x: 30,
                                      y: profileImageView.bottom + 10,
                                      width: scrollView.width - 60,
                                      height: 52)
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        registerButton.frame = CGRect(x: 30,
                                      y: passwordField.bottom + 20,
                                      width: scrollView.width - 60,
                                      height: 42)
    }
    
    @objc private func didRegisterTapped() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6 else {
            alertUserLogInerror()
            return
        }
        
        //Firebase reg
        DataBaseManager.shared.userExists(with: email) { [weak self] exists in
            guard let strongSelf = self else { return }
            guard !exists else {
                //user already exist
                strongSelf.alertUserLogInerror(message: "Looks like user account for that email adress already exists !")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Error creating user")
                    return
                }
                
                DataBaseManager.shared.inserUser(with: ChatAppUser(firstName: firstName,
                                                                   lastName: lastName,
                                                                   emailAdress: email))
                strongSelf.navigationController?.dismiss(animated: true)
            }
        }
    }
    
    func alertUserLogInerror(message: String = "Please complete all fields\nPassword should contains more than 6 characters") {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didRegisterTapped()
        }
        
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSHeet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)
        
        actionSHeet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        actionSHeet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSHeet.addAction(UIAlertAction(title: "Chose Photo", style: .default, handler: { [weak self] _ in
            self?.presentLibrary()
        }))
        
        present(actionSHeet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.profileImageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
