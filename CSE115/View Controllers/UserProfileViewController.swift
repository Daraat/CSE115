//
//  UserProfileViewController.swift
//  CSE115
//
//  Created by user175073 on 7/15/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import Foundation
import UIKit
class UserProfileViewController: UIViewController {
    @IBOOutlet var profileImg: UIImageView!
    override func viewDidLoad(){
        super.viewDidLoad
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning
    }
}
