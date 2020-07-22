//
//  profileEditPage.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 7/21/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper
import Firebase
import FirebaseDatabase


class profileEditPage: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    
    
    
    
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameEdit: UITextField!
    @IBOutlet weak var nameEdit: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
             
              profilePic.makeRound()
              
              
          }
    
    
    @IBAction func editPictureKey(_ sender: Any) {
        
        
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("EDIT PIC: Library accessed")
                
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false
                
                present(imagePicker, animated: true, completion: nil)
                
                
            }
        
        
        
     
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var newImage: UIImage

            if let possibleImage = info[.editedImage] as? UIImage {
                newImage = possibleImage
            } else if let possibleImage = info[.originalImage] as? UIImage {
                newImage = possibleImage
            } else {
                return
            }

            profilePic.image = newImage
            
            dismiss(animated: true)
        }
        }
    
    
    @IBAction func compKey(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

        
        
        
    }
    
    
    
    
    
    
    }
    
    
    
    

