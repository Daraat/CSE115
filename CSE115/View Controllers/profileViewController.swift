//
//  profileViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 7/17/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit



class profileViewController: UIViewController{
    
    
   

    @IBAction func Backbut(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var profileP: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileP.makeRound()
        
        
        
   
    }
    
}
