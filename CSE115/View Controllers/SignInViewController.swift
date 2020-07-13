//
//  ViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 6/29/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

//Extends UIVC to close the keyboard when we click outside of the text box
//Credit Esqarrouth & IgniteCoders: https://stackoverflow.com/a/27079103

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    
    let backgroundImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setBackgound()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if KeychainWrapper.standard.hasValue(forKey: KEY_UID){
            print("UID Found in keychain")
            performSegue(withIdentifier: "goToHome", sender: nil)
        }
    }
    
    func setBackgound(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    
    @IBAction func signbut(_ sender: Any) {
        
        guard let email =  emailTxt.text, !email.isEmpty,
                let password = passTxt.text, !password.isEmpty
        else{
            print("Fields missing data")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
            if error != nil{
                print("LOGIN: User login failed")
                print(error ?? "Error not provided")
                return
            }else{
                KeychainWrapper.standard.set((result?.user.uid)!, forKey: KEY_UID)
                print("SIGNUP: User login succesful")
                self.performSegue(withIdentifier: "goToHome", sender: nil)
            }
        })
        
        
    }
    

    @IBAction func RegBut(_ sender: Any) {
        performSegue(withIdentifier: "gotoSignUp", sender: nil)
        
    }
    
    @IBAction func GoogleBut(_ sender: Any) {
        
    }
}
