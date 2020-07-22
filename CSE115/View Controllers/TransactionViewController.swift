//
//  TransactionViewController.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/11/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class TransactionViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    
    @IBOutlet weak var ItemTextField: UITextField!
    @IBOutlet weak var friendSearchField: UITextField!
    @IBOutlet weak var returnDateText: UITextField!
    @IBOutlet weak var loanDateText: UITextField!
    @IBOutlet weak var userNotFoundLabel: UILabel!
    
    @IBOutlet weak var addPicBtn: UIButton!
    @IBOutlet weak var addPicBtnLeftconstraint: NSLayoutConstraint!
    @IBOutlet weak var addPicBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addPicBtnRightConstraint: NSLayoutConstraint!
    
    
    let dbRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    var usrFound = false
    var data :Dictionary<String, Any> = [
        "loanerHandle" : "",
        "loaneeHandle" : "",
        "itemName" : "",
        "loanDate" : "",
        "returnDate":"",
        "imgPath" : "",
        "owner" : true
    ]
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func picTaker(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        
        addPicBtnLeftconstraint.constant = 79
        addPicBtnRightConstraint.constant = 89
        addPicBtnHeightConstraint.constant = 246
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        addPicBtn.setImage(image, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        userNotFoundLabel.alpha = 0
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(TransactionViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        loanDateText.inputView = datePicker
        returnDateText.inputView = datePicker
        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(backgroundTap(gesture:)));
        view.addGestureRecognizer(gestureRecognizer)
        
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        dbRef.child("userHandlesByID").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            self.data["loanerHandle"] = snapshot.value!
        })
    }
    @IBAction func searchUser(_ sender: Any) {
        isUserFound()
            }
    
    func isUserFound(){
        var handle = friendSearchField.text!

        //adding the '@' if user hasn't
        if handle.prefix(1) != "@"{
            handle = "@"+handle
        }
        
        dbRef.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChild(handle){
                self.friendSearchField.layer.borderWidth = 1.0
                self.friendSearchField.layer.borderColor = UIColor.red.cgColor
                self.userNotFoundLabel.alpha = 1
                self.usrFound = false
            } else {
                self.friendSearchField.layer.borderWidth = 0
                self.usrFound = true
                self.userNotFoundLabel.alpha = 0
                print("user found")
                self.data["loaneeHandle"] = handle
            }
        })
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter  = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        if(loanDateText.isEditing){
            loanDateText.text = formatter.string(from: sender.date)
        }
        else{
        returnDateText.text = formatter.string(from: sender.date)
        }
}
    @objc func backgroundTap(gesture : UITapGestureRecognizer) {
           returnDateText.resignFirstResponder()
           loanDateText.resignFirstResponder()
       }
    @IBAction func addButtonPressed(_ sender: Any) {
        var err = false
        
        isUserFound()
        if !usrFound{
            print("no")
            return
        }
        
        if !ItemTextField.hasText{
            ItemTextField.layer.borderWidth = 1.0
            ItemTextField.layer.borderColor = UIColor.red.cgColor
            err = true
        }else{
            data["itemName"] = ItemTextField.text!
        }
        
        if !loanDateText.hasText{
            self.loanDateText.layer.borderWidth = 1.0
            self.loanDateText.layer.borderColor = UIColor.red.cgColor
            err = true
        }else{
            data["loanDate"] = loanDateText.text!
        }
        
        
        if !returnDateText.hasText{
            self.returnDateText.layer.borderWidth = 1.0
            self.returnDateText.layer.borderColor = UIColor.red.cgColor
            err = true
        }else{
            data["returnDate"] = returnDateText.text!
        }
        
        if err{
            print("err")
            return
        } else{
            let transID = dbRef.child("users").child(data["loanerHandle"] as! String).child("transactions").childByAutoId().key!
            dbRef.child("users").child(data["loanerHandle"] as! String).child("transactions").child(transID).setValue(self.data)
            
            //get jpegData to be uploaded
            guard let pic = addPicBtn.image(for: .normal)!.jpegData(compressionQuality: 10.0) else {
                    print("UPLDPROFPIC: error in getting jpegData")
                return
            }
            
            let pathish = ((self.data["loanerHandle"]  as! String) + (self.data["loaneeHandle"]  as! String) + (self.data["itemName"]  as! String) + ".jpg")
            //creates a reference to the image in firebase storage
            let itemPicRef = storageRef.child("TransactionItems/").child(pathish)
            
//            uploads the image
            itemPicRef.putData(pic, metadata: nil)
            self.data["imgPath"] = itemPicRef.fullPath

            data["owner"] = false
            dbRef.child("users").child(data["loaneeHandle"] as! String).child("transactions").child(transID).setValue(data)
            print("transaction succesfully created")
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}
    