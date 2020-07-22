//
//  profileViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 7/17/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit



class profileViewController: UIViewController{
    
    

    @IBOutlet weak var nameTag: UILabel!
    @IBOutlet weak var transactionTag: UILabel!
    @IBOutlet weak var lastNameTag: UILabel!
    @IBAction func Backbut(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profileEditPage(_ sender: Any) {
        
    }
    
    @IBOutlet weak var profileP: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileP.makeRound()
        
        
        
   
    }
    
}
