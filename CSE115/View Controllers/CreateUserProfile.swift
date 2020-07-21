//
//  CreateUserProfile.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/18/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class CreateUserProfile : UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var handle: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var fieldsErrMsg: UILabel!
    @IBOutlet weak var handleErrMsg: UILabel!
    

    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    var imagePicker = UIImagePickerController()
    var handleData = ""
    var userData: Dictionary<String, Any> = [
        "firstName" : "",
        "lastName" : "",
        "profilePicPath" : "",
        "email" : ""
    ]
    
    override func viewDidLoad() {
        fieldsErrMsg.alpha = 0.0
        handleErrMsg.alpha = 0.0
        userData["email"] = Auth.auth().currentUser?.email
    }
    
    //Access phone library, updates image view, uploads the image to the database
    @IBAction func editPicPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("EDIT PIC: Library accessed")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    //handles the user picking an image and updates the current profile pic
    //Credit Paul Hudson for HackingWithSwift.com : https://www.hackingwithswift.com/example-code/media/how-to-choose-a-photo-from-the-camera-roll-using-uiimagepickercontroller
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

    
    //Checks if fields are filled in, checks availability of handle, uploads everything to the database to finish setting up user profile
    @IBAction func completeBtnPressed(_ sender: Any) {
        var err = false
        handleErrMsg.alpha = 0.0
        fieldsErrMsg.alpha = 0.0
        
        if firstName.hasText{
            userData["firstName"] = firstName.text
        } else {
            firstName.layer.borderWidth = 1.0
            firstName.layer.borderColor = UIColor.red.cgColor
            err = true
        }
        
        if lastName.hasText{
            userData["lastName"] = lastName.text
        } else {
            lastName.layer.borderWidth = 1.0
            lastName.layer.borderColor = UIColor.red.cgColor
            err = true
        }
        
        if handle.hasText{
            handleData = handle.text!
            if handleData.prefix(1) != "@"{
                handleData = "@"+handleData
            }
        } else {
            handle.layer.borderWidth = 1.0
            handle.layer.borderColor = UIColor.red.cgColor
            err = true
        }
        
        if err {
            UIView.animate(withDuration: 0.5){
                self.fieldsErrMsg.alpha = 1.0
            }
            
        } else {
            uploadProfilePicToFireStore()
            //Checks if the handle is available
            let handle = self.handleData
            if(handle.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) != nil){
                handleErrMsg.text = "Whitespaces are not allowed in handle"
                UIView.animate(withDuration: 0.5){
                    self.handleErrMsg.alpha = 1.0
                }
                return
            }
            databaseRef.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(handle){
                    self.handleErrMsg.text = "This handle is taken. Please choose another one"
                    UIView.animate(withDuration: 0.5){
                        self.handleErrMsg.alpha = 1.0
                    }
                }
                else{
                    self.databaseRef.child("users").child(handle).setValue(self.userData)
                    self.databaseRef.child("userHandlesByID").child(Auth.auth().currentUser!.uid).setValue(handle)
                    print("Success, user profile created.")
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    
                }
            })
        }
        
    }
    
    //uploads the current image assigned to profilePic to the Firebase storage and returns the download URL
    func uploadProfilePicToFireStore(){
        
        //get jpegData to be uploaded
        guard let data = profilePic.image?.jpegData(compressionQuality: 1.0) else {
            print("UPLDPROFPIC: error in getting jpegData")
            return
        }
        
        //creates a reference to the image in firebase storage
        let profilePicRef = storageRef.child("Profile Pics/" + handle.text! + "ProfilePic.jpg")
        
        //uploads the image
        profilePicRef.putData(data, metadata: nil)
        self.userData["profilePicPath"] = profilePicRef.fullPath
        
    }
}
