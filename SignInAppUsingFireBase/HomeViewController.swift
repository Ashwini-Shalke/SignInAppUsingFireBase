//
//  WelcomeScreen.swift
//  SignInAppUsingFireBase
//
//  Created by Ashwini shalke on 07/05/21.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
    
    let db = Firestore.firestore()
    var userId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let user = Auth.auth().currentUser {
            userId = user.uid
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        setupLayout()
        modifyDocument()
        
        
    }
    
    var quoteField: UITextField = {
        var quoteField = UITextField()
        quoteField.placeholder = "Quote"
        quoteField.tintColor = .blue
        quoteField.borderStyle = .roundedRect
        quoteField.translatesAutoresizingMaskIntoConstraints = false
        return quoteField
    }()
    
    var authorField: UITextField = {
        var authorField = UITextField()
        authorField.placeholder = "Author"
        authorField.tintColor = .blue
        authorField.borderStyle = .roundedRect
        authorField.translatesAutoresizingMaskIntoConstraints = false
        return authorField
    }()
    
    var saveButton: UIButton = {
        var saveButton = UIButton()
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    var showAll: UIButton = {
        var showAll = UIButton()
        showAll.backgroundColor = .systemBlue
        showAll.setTitleColor(.white, for: .normal)
        showAll.setTitle("Show All", for: .normal)
        showAll.translatesAutoresizingMaskIntoConstraints = false
        return showAll
    }()
    
    var signOut: UIButton = {
        var signOut = UIButton()
        signOut.backgroundColor = .systemRed
        signOut.setTitleColor(.white, for: .normal)
        signOut.setTitle("Sign Out", for: .normal)
        signOut.translatesAutoresizingMaskIntoConstraints = false
        return signOut
    }()
    
    func setupLayout(){
        view.addSubview(quoteField)
        NSLayoutConstraint.activate([quoteField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                                     quoteField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     quoteField.widthAnchor.constraint(equalToConstant: 300),
                                     quoteField.heightAnchor.constraint(equalToConstant: 40)])
        
        view.addSubview(authorField)
        NSLayoutConstraint.activate([authorField.topAnchor.constraint(equalTo: quoteField.bottomAnchor, constant: 20),
                                     authorField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     authorField.widthAnchor.constraint(equalToConstant: 300),
                                     authorField.heightAnchor.constraint(equalToConstant: 40)])
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([saveButton.topAnchor.constraint(equalTo: authorField.bottomAnchor, constant: 20),
                                     saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     saveButton.widthAnchor.constraint(equalToConstant: 100),
                                     saveButton.heightAnchor.constraint(equalToConstant: 40)])
        saveButton.addTarget(self, action: #selector(didTapSave(_:)), for: .touchUpInside)
        
        view.addSubview(showAll)
        NSLayoutConstraint.activate([showAll.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
                                     showAll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     showAll.widthAnchor.constraint(equalToConstant: 100),
                                     showAll.heightAnchor.constraint(equalToConstant: 40)])
        showAll.addTarget(self, action: #selector(readNotesData), for: .touchUpInside)
        
        view.addSubview(signOut)
        NSLayoutConstraint.activate([signOut.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                                     signOut.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     signOut.widthAnchor.constraint(equalToConstant: 300),
                                     signOut.heightAnchor.constraint(equalToConstant: 40)])
        signOut.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
    }
    
    @objc func didTapSave(_ sender: UIBarButtonItem) {
        guard let quote = quoteField.text else { return }
        guard let author = authorField.text else { return }
        let newDocument = db.collection(userId).document()
        newDocument.setData(["quote": quote,
                             "author":author,
                             "id":newDocument.documentID])
        quoteField.text = " " ; authorField.text = " "
        
    }
    
    func modifyDocument(){
        db.collection(userId)
            .document("gElX1ZjqSsDbHCvREgKB")
            .setData(["quote": "what you think you become",
                      "author": "Ashwini Shalke"], merge : true)
    }
    
    @objc func readNotesData(){
        db.collection(userId).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let documentData = document.data()
                    print("List of notes from \(self.userId) : \(documentData)")
                }
            }
        }
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
