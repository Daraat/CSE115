//
//  HomeViewController.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/21/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import SideMenu

struct cellStruct{
    let transID : String!
    let from : String!
    let to : String!
    let item : String!
    let loanDate : String!
    let returnDate : String!
    let imgPath : String!
}

class HomeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var feedTableView: UITableView!
    
    let dbRef = Database.database().reference().child("users")
    let storageRef = Storage.storage().reference()
    let handle = KeychainWrapper.standard.string(forKey: USR_HANDLE)!
    
    var curCell = UITableViewCell()
    var cells = [cellStruct]()
    
    override func viewDidLoad() {
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        dbRef.child(handle).child("transactions").queryOrderedByKey().observe(.childRemoved, with:{ (snapshot) in
            self.cells.removeAll(where: {$0.transID == snapshot.key})
            self.feedTableView.reloadData()
        })
        
        dbRef.child(handle).child("transactions").queryOrderedByKey().observe(.childAdded, with:{ (snapshot) in
            
            let transid = snapshot.key
            let dict = snapshot.value as! Dictionary<String, Any>
            let item = dict["itemName"] as! String
            let imgPath = dict["imgPath"] as! String
            let from = dict["loanerHandle"] as! String
            let to = dict["loaneeHandle"] as! String
            let loanDate = dict["loanDate"] as! String
            let returnDate = dict["returnDate"] as! String
            
            self.cells.insert(cellStruct(transID: transid, from: from, to: to, item: item, loanDate: loanDate,returnDate: returnDate , imgPath: imgPath), at: 0)
            self.feedTableView.reloadData()

        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "transactionCell")
        let curCell = cells[indexPath.row]
        let img = cell?.viewWithTag(1) as! UIImageView
        let itemLbl = cell?.viewWithTag(2) as! UILabel
        let fromLbl = cell?.viewWithTag(3) as! UILabel
        let toLbl = cell?.viewWithTag(4) as! UILabel
        let dateLbl = cell?.viewWithTag(5) as! UILabel
        let transID = cell?.viewWithTag(6) as! UILabel
        let returnDate = cell?.viewWithTag(7) as! UILabel
        
        storageRef.child(curCell.imgPath).getData(maxSize: 1 * 2048 * 2048, completion: { data, error in
            if let error = error {
                print("PIC: ",error)
            } else {
                img.image = UIImage(data: data!)
            }
        })
        
        itemLbl.text = curCell.item
        fromLbl.text = curCell.from
        toLbl.text = curCell.to
        dateLbl.text = curCell.loanDate
        transID.text = curCell.transID
        returnDate.text = curCell.returnDate
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.curCell = tableView .cellForRow(at: indexPath)! as UITableViewCell
        performSegue(withIdentifier: "goToDetails", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails"{
            if let destination = segue.destination as? transDetailViewController{
                let itemLbl = curCell.viewWithTag(2) as! UILabel
                let fromLbl = curCell.viewWithTag(3) as! UILabel
                let toLbl = curCell.viewWithTag(4) as! UILabel
                let dateLbl = curCell.viewWithTag(5) as! UILabel
                let transID = curCell.viewWithTag(6) as! UILabel
                let returnDate = curCell.viewWithTag(7) as! UILabel
                
                destination.fromText = fromLbl.text!
                destination.itemNameText = itemLbl.text!
                destination.toText = toLbl.text!
                destination.startText = dateLbl.text!
                destination.returnText = returnDate.text!
                destination.transID = transID.text!
            }
        }
    }
    
}
