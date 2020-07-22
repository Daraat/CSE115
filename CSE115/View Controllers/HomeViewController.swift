//
//  HomeViewController.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/21/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import SideMenu

struct cell{
    let from : String!
    let to : String!
    let item : String!
    let loanDate : String!
    let imgPath : String!
    let owner : Bool!
}

class HomeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    override func viewDidLoad() {
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
}
