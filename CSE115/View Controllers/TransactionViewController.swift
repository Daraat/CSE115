//
//  TransactionViewController.swift
//  CSE115
//
//  Created by Raphael Zaafrani on 7/11/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit
import Firebase

class TransactionViewController: UIViewController {

    
    
    @IBOutlet weak var returnDateText: UITextField!
    @IBOutlet weak var loanDateText: UITextField!
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var addPic: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(TransactionViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        loanDateText.inputView = datePicker
        returnDateText.inputView = datePicker
        
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
    
    
}
