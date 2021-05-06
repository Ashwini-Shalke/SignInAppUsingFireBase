//
//  ViewController.swift
//  SignInAppUsingFireBase
//
//  Created by Ashwini shalke on 03/05/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let a = Auth.auth().currentUser {
      
        }
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
    
    var signIn: UIButton = {
        var signIn = UIButton()
        signIn.backgroundColor = .systemBlue
        signIn.setTitleColor(.white, for: .normal)
        signIn.setTitle("Sign In", for: .normal)
        signIn.translatesAutoresizingMaskIntoConstraints = false
        return signIn
    }()
    
    var noAccount: UILabel = {
        var noAccount = UILabel()
        noAccount.text = "No account?"
        noAccount.textAlignment = .right
        noAccount.font = UIFont.systemFont(ofSize: 17)
        noAccount.translatesAutoresizingMaskIntoConstraints = false
        return noAccount
    }()
    
    var register: UIButton = {
        var register = UIButton()
        register.setTitle("Register", for: .normal)
        register.setTitleColor(.systemBlue, for: .normal)
        register.contentHorizontalAlignment = .left
        register.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        register.translatesAutoresizingMaskIntoConstraints = false
        return register
    }()
    
    var forgotPassword: UIButton = {
        var forgotPassword = UIButton()
        forgotPassword.setTitle("Forgot Password?", for: .normal)
        forgotPassword.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        forgotPassword.setTitleColor(UIColor.systemBlue, for: .normal)
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
        return forgotPassword
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
        
        view.addSubview(signIn)
        NSLayoutConstraint.activate([signIn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
                                     signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     signIn.widthAnchor.constraint(equalToConstant: 300),
                                     signIn.heightAnchor.constraint(equalToConstant: 40)])
        
        register.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [noAccount,register])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.autoresizesSubviews = true
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: signIn.bottomAnchor, constant: 30),
                                     stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.heightAnchor.constraint(equalToConstant: 30)])
                                     
        
        view.addSubview(forgotPassword)
        NSLayoutConstraint.activate([forgotPassword.topAnchor.constraint(equalTo: stackView .bottomAnchor, constant: 10),
                                     forgotPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     forgotPassword.widthAnchor.constraint(equalToConstant: 300),
                                     forgotPassword.heightAnchor.constraint(equalToConstant: 30)])
        
        
        
    }
    
    @objc func handleRegister(){
        let signUp = SignUpViewController()
        signUp.modalPresentationStyle = .fullScreen
        self.present(signUp, animated: true, completion: nil)
    }
}

