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
import SideMenu

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
    }
    
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        //dismiss(animated: true, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    
}
