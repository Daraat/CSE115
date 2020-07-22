//
//  profileViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 7/17/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class profileViewController: UIViewController{
    
    
    @IBOutlet weak var profileP: UIImageView!
    @IBOutlet weak var nameTag: UILabel!
    @IBOutlet weak var transactionTag: UILabel!
    @IBOutlet weak var lastNameTag: UILabel!
    
    let dbRef = Database.database().reference().child("users")
    let storageRef = Storage.storage().reference()
    let handle = KeychainWrapper.standard.string(forKey: USR_HANDLE)!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        profileP.makeRound()
        //update first name
        dbRef.child(handle).child("firstName").observeSingleEvent(of: .value, with: { (snapshot) in
            self.nameTag.text = (snapshot.value as! String)
        })
        
        //update last name
        dbRef.child(handle).child("lastName").observeSingleEvent(of: .value, with: { (snapshot) in
            self.lastNameTag.text = (snapshot.value as! String)
        })
        
        //update picture
        dbRef.child(handle).child("profilePicPath").observeSingleEvent(of: .value, with: { (snapshot) in
            let imgRef = self.storageRef.child(snapshot.value as! String)
            
            imgRef.getData(maxSize: 1 * 2048 * 2048, completion: { data, error in
                if let error = error {
                    print("PROFPIC: ",error)
                } else {
                    self.profileP.image = UIImage(data: data!)
                }
            })
        })

     }
    
    
    @IBAction func Backbut(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
}
