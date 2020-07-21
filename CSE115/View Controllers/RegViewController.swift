//
//  RegViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 6/30/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper
class RegViewController: UIViewController {


    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPassWordTextField: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //See SignInViewController line 16
        self.hideKeyboardWhenTappedAround()
        errorMsg.alpha = 0.0
    
    // Do any additional setup after loading the view.
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func regFinal(_ sender: Any) {
        //TODO: Improve email and password validation
        guard let email = EmailTextField.text, !email.isEmpty,
            let password = PasswordTextField.text, !password.isEmpty,
            let passwordConf = ConfirmPassWordTextField.text, passwordConf == password
            else{
                errorMsg.text = "Please make sure your info is correct"
                UIView.animate(withDuration: 0.5){
                    self.errorMsg.alpha = 1.0
                }
                return
        }
        //creates user in firebase database
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            if error != nil{
                print("SIGNUP: User creation failed")
                self.errorMsg.text = "This Email is already taken"
                UIView.animate(withDuration: 0.5){
                    self.errorMsg.alpha = 1.0
                }
                return
            }else{
                print("SIGNUP: User creation succesful")
                KeychainWrapper.standard.set((result?.user.uid)!, forKey: KEY_UID)
                self.performSegue(withIdentifier: "goToProfileSetUp", sender: nil)
            }
        })
    }
}
