//
//  SignUpViewController.swift
//  SignInAppUsingFireBase
//
//  Created by Ashwini shalke on 06/05/21.
//

import UIKit

class SignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    var emailField: UITextField = {
        var emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.tintColor = .blue
        emailField.borderStyle = .roundedRect
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }()
    
    var passwordField: UITextField = {
        var passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.tintColor = .blue
        passwordField.borderStyle = .roundedRect
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    
    var createAccount: UIButton = {
        var createAccount = UIButton()
        createAccount.backgroundColor = .systemBlue
        createAccount.setTitleColor(.white, for: .normal)
        createAccount.setTitle("Create Account", for: .normal)
        createAccount.translatesAutoresizingMaskIntoConstraints = false
        return createAccount
    }()
    
    var alreadyAccount: UILabel = {
        var alreadyAccount = UILabel()
        alreadyAccount.text = "Already have an account?"
        alreadyAccount.textAlignment = .right
        alreadyAccount.font = UIFont.systemFont(ofSize: 17)
        alreadyAccount.translatesAutoresizingMaskIntoConstraints = false
        return alreadyAccount
    }()
    
    var login: UIButton = {
        var login = UIButton()
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.systemBlue, for: .normal)
        login.contentHorizontalAlignment = .left
        login.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    
    func setupLayout(){
        view.addSubview(emailField)
        NSLayoutConstraint.activate([emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
                                        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        emailField.widthAnchor.constraint(equalToConstant: 300),
                                        emailField.heightAnchor.constraint(equalToConstant: 40)])
        
        view.addSubview(passwordField)
        NSLayoutConstraint.activate([passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
                                      passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                      passwordField.widthAnchor.constraint(equalToConstant: 300),
                                      passwordField.heightAnchor.constraint(equalToConstant: 40)])
        
        view.addSubview(createAccount)
        NSLayoutConstraint.activate([createAccount.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
                                     createAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     createAccount.widthAnchor.constraint(equalToConstant: 300),
                                     createAccount.heightAnchor.constraint(equalToConstant: 40)])
        
        login.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [alreadyAccount,login])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.autoresizesSubviews = true
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: createAccount.bottomAnchor, constant: 30),
                                     stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    @objc func handleLogin(){
        self.dismiss(animated: true, completion: nil)

    }
}
