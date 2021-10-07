//
//  DateTimePicker.swift
//  DateTimePicker
//
//  Created by reza on 7/15/1400 AP.
//

import UIKit

class DateTimePicker: UITextField{

    var datePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    var currentDate: Date?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuration()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    func configuration(){
        // set delegate of textField to it self
        self.delegate = self
        
        /*
         call createDatePicker for when textField tapped, show datePicker insted of keyboard
         */
        createDatePicker()
        
        
        /*
         This func for set text of textField when datePicker value changed
         */
        datePicker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    
    /*
     can call setCurrentDate func to set initail of textField text with custome date
     */
    func setCurrentDate( date: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        self.text = dateFormatter.string(from: date) + "  " + timeFormatter.string(from: date)
        
        currentDate = date
    }
    
    
    /*
     set date picker when textField tapped for get date and next button
     */
    @objc func createDatePicker(){
        //barButton
        let nextBtn = UIBarButtonItem(title: "next", style: .done, target: self, action: #selector(createTimePicker))

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //toolBar
        toolBar.sizeToFit()
        toolBar.setItems([flexibleSpace, nextBtn], animated: true)
        
        self.inputAccessoryView = toolBar

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setDate(currentDate ?? Date(), animated: true)
        datePicker.datePickerMode = .date
        
        self.inputView = datePicker
    }
    
    
    /*
     change date picker UI for set time
     */
    @objc func createTimePicker(){
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(endPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let previousBtn = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(createDatePicker))
        
        //toolBar
        toolBar.setItems([previousBtn, flexibleSpace, doneBtn], animated: true)

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setDate(currentDate ?? Date(), animated: true)
        datePicker.datePickerMode = .time
        
    }
    
    @objc func valueChanged(){
        currentDate = datePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
    
        self.text = dateFormatter.string(from: currentDate ?? Date()) + "  " + timeFormatter.string(from: currentDate ?? Date())
        self.loadWithAnimation()
        
        }
    

    @objc func endPicker(){
        //It's for set datePicker UI to get date for next step 🙂
        createDatePicker()
        
        //If textField is empty this fix it
        if self.text == nil || self.text == ""{
            setCurrentDate(date: currentDate ?? Date())
        }
        
        //Close DatePicker
        self.endEditing(true)
    }
    
    
    /*
     This function for prevent user to cut or paste text to textField and ...
     */
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) ||
            action == #selector(cut(_:)) ||
            action == #selector(select(_:)) ||
            action == #selector(selectAll(_:)) ||
            action == #selector(delete(_:)) ||
            action == #selector(makeTextWritingDirectionLeftToRight(_:)) ||
            action == #selector(makeTextWritingDirectionRightToLeft(_:)) ||
            action == #selector(toggleBoldface(_:)) ||
            action == #selector(toggleItalics(_:)) ||
            action == #selector(toggleUnderline(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}


// MARK: TextField Delegate

extension DateTimePicker: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        endPicker()
    }
    
}


// MARK: TextField Animation

extension UITextField{

    
    /*
     change textField text with animation
     */

    func loadWithAnimation(){
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.type = CATransitionType.fade //1.
        animation.subtype = .none
        
        animation.duration = 0.3
        self.layer.add(animation, forKey: CATransitionType.fade.rawValue)//2.
    }
    
}
