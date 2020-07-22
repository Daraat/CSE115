//
//  HomeViewController.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/11/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper
import SideMenu

class MenuViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    let dbRef = Database.database().reference()
    
    var userHandle = ""
    var userFirstName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        profilePic.makeRound()
        dbRef.child("userHandlesByID").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            self.userHandle = snapshot.value as! String

            self.dbRef.child("users").child(self.userHandle).child("firstName").observeSingleEvent(of: .value, with: { (snapshot) in
                self.userFirstName = snapshot.value as! String
                self.nameLabel.text = "Hello, "+self.userFirstName
            })

            self.dbRef.child("users").child(self.userHandle).child("profilePicPath").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let imgRef = Storage.storage().reference(withPath: snapshot.value as! String)
                
                imgRef.getData(maxSize: 1 * 2048 * 2048, completion: { data, error in
                    if let error = error {
                        print("PROFPIC: ",error)
                    } else {
                        self.profilePic.image = UIImage(data: data!)
                    }
                })

            })
        })
        profilePic.makeRound()
    }
    
    

    @IBAction func logOutBtnPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        KeychainWrapper.standard.removeObject(forKey: USR_HANDLE)
        //dismiss(animated: true, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
}
