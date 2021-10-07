//
//  ViewController.swift
//  DateTimePicker
//
//  Created by reza on 7/15/1400 AP.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: DateTimePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set defualt value of textField
        textField.setCurrentDate(date: Date())
    }

}

