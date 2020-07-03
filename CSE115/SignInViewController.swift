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

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    
    let backgroundImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setBackgound()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if KeychainWrapper.standard.hasValue(forKey: KEY_UID){
            print("UID Found in keychain")
            performSegue(withIdentifier: "TODO", sender: nil)
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
        
        let MyEmail =  String(emailTxt.text!)
        let MyPass = String(passTxt.text!)
        
        if(isValidEmail(MyEmail) && MyPass != ""){
            completeSignIn(email: MyEmail, password: MyPass)
        }
        
    }
    

    @IBAction func RegBut(_ sender: Any) {
        performSegue(withIdentifier: "gotoSignUp", sender: nil)
    }
    
    @IBAction func GoogleBut(_ sender: Any) {
        
    }
    
    func completeSignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: nil!)
       //let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
       // print("Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "TODO", sender: nil)
    }
    
    //Credit Maxim Shoustin & Zandor Smith: https://stackoverflow.com/a/25471164
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
