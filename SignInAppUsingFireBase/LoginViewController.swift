//
//  ViewController.swift
//  SignInAppUsingFireBase
//
//  Created by Ashwini shalke on 03/05/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = Auth.auth().currentUser {
            self.handleSignIn()
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
        passwordField.isSecureTextEntry = true
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
        signIn.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        forgotPassword.addTarget(self, action: #selector(didRequestPasswordReset), for: .touchUpInside)
    }
    
    @objc func handleRegister(){
        let signUp = SignUpViewController()
        signUp.modalPresentationStyle = .fullScreen
        self.present(signUp, animated: true, completion: nil)
    }
    
    
    @objc func handleSignIn(){
        let homeView = HomeViewController()
        homeView.modalPresentationStyle = .fullScreen
        self.present(homeView, animated: true, completion: nil)
    }
    
    @objc func didTapSignIn(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
                guard let _ = user else {
                    if let error = error {
                        if let errCode = AuthErrorCode(rawValue: error._code) {
                            print (errCode)
                            switch errCode {
                            case .userNotFound:
                                self.showAlert("User account not found. Try registering")
                            case .wrongPassword:
                                self.showAlert("Incorrect username/password combination")
                            default:
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                        return
                    }
                    assertionFailure("user and error are nil")
                    return
                }
            
            self.handleSignIn()
            })
        }
    
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Simple App", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func didRequestPasswordReset(_ sender: UIButton) {
        let prompt = UIAlertController(title: "To Do App", message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            Auth.auth().sendPasswordReset(withEmail: userInput!, completion: { (error) in
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            DispatchQueue.main.async {
                                self.showAlert("User account not found. Try registering")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.showAlert("You'll receive an email shortly to reset your password.")
                    }
                }
            })
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



