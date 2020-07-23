//
//  transDetailViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 7/21/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//


import UIKit
import Firebase
import SwiftKeychainWrapper

class transDetailViewController: UIViewController {
    
    
    let handle = KeychainWrapper.standard.string(forKey: USR_HANDLE)!
    let dbRef = Database.database().reference().child("users")
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
    
    var transID = ""
    var itemNameText = ""
    var fromText = ""
    var toText = ""
    var startText = ""
    var returnText = ""
    
    override func viewDidLoad() {
        itemName.text = itemNameText
        fromLbl.text = fromText
        toLbl.text = toText
        startDate.text = startText
        returnDate.text = returnText
        
        print(transID)
    }
    
    @IBAction func completedBtnPressed(_ sender: Any) {
        dbRef.child(handle).child("transactions").child(transID).observe(.value, with: { (snapshot) in
            self.dbRef.child(self.handle).child("completed transactions").child(self.transID).setValue(snapshot.value)
        })
        dbRef.child(handle).child("transactions").child(transID).removeValue()
        
        dismiss(animated: true, completion: nil)
    }
    
}
