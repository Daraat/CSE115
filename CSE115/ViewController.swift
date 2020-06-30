//
//  ViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 6/29/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    
    let backgroundImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setBackgound()
        // Do any additional setup after loading the view.
    }
    func setBackgound(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        
        
        
    }
    
    
    @IBAction func signbut(_ sender: Any) {
        
        let MyEmail =  String(emailTxt.text!)
        let MyPass = String(passTxt.text!)
        if(MyPass=="" && MyEmail == " " ){
            
        }
        
    }
    
    @IBAction func regBut(_ sender: Any) {
        
        
    }
    
    @IBAction func GoogleBut(_ sender: Any) {
        
        
        
        
    }
}
