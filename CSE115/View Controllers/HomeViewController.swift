//
//  HomeViewController.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/21/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController : UIViewController{
    override func viewDidLoad() {
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
}
