//
//  WelcomeScreen.swift
//  SignInAppUsingFireBase
//
//  Created by Ashwini shalke on 07/05/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        setupLayout()
    }
    
    var signOut: UIButton = {
        var signOut = UIButton()
        signOut.backgroundColor = .systemBlue
        signOut.setTitleColor(.white, for: .normal)
        signOut.setTitle("Sign Out", for: .normal)
        signOut.translatesAutoresizingMaskIntoConstraints = false
        return signOut
    }()
    
    func setupLayout(){
        view.addSubview(signOut)
        NSLayoutConstraint.activate([signOut.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     signOut.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     signOut.widthAnchor.constraint(equalToConstant: 300),
                                     signOut.heightAnchor.constraint(equalToConstant: 40)])
        
        signOut.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func didTapSignOut(_ sender: UIBarButtonItem) {
        let login = LoginViewController()
        login.modalPresentationStyle = .fullScreen
        do {
            try Auth.auth().signOut()
            self.present(login, animated: true, completion: nil)
        } catch let error {
            assertionFailure("Error signing out: \(error)")
        }
    }
}
