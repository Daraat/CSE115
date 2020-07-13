//
//  HomeViewController.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/11/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper


class HomeViewController: UIViewController {
    @IBAction func logOutBtnPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        dismiss(animated: true, completion: nil)
    }
    
    
}
