//
//  RegViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 6/30/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import FirebaseAuth
class RegViewController: UIViewController {


    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPassWordTextField: UITextField!
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    
    // Do any additional setup after loading the view.
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func regFinal(_ sender: Any) {
        guard let email = EmailTextField.text, !email.isEmpty,
            let password = PasswordTextField.text, !password.isEmpty,
            let passwordConf = ConfirmPassWordTextField.text, passwordConf == password
            else{
                print("Fields missing data")
                return
        }
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            if error != nil{
                print("SIGNUP: User creation failed")
                return
            }else{
                print("SIGNUP: User creation succesful")
                //TODO: perform segue
            }
        })
    }
}
