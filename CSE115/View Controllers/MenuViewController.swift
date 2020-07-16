//
//  MenuViewController.swift
//  CSE115
//
//  Created by user175042 on 7/10/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import Foundation
import UIKit


class MenuController: UIViewController {
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    var menuOut = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func MenuTapped(_ sender: Any) {
        if menuOut == false {
            leading.constant = 150
            trailing.constant = -150
            menuOut = true
        }else{
            leading.constant = 0
            trailing.constant = 0
            menuOut = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("menu tap complete")
        }
    }
    
}
