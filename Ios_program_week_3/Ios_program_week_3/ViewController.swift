//
//  ViewController.swift
//  Ios_program_week_3
//
//  Created by Capstone on 2023/03/20.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var fahreheitTextField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var myview: UIView!
    var myDelegate: MyDelegate!
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        fahreheitTextField.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*//파란색 사각형
        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
        let firstView = UIView(frame: firstFrame)
        firstView.backgroundColor = UIColor.blue
        
        view.addSubview(firstView)
        */
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        myview.addGestureRecognizer(tapGesture)
        
        
        myDelegate = MyDelegate()
        fahreheitTextField.delegate = myDelegate
        
    }
    
    @IBAction func fahreheitEditingChange(_ sender: UITextField) {
        if let text = sender.text {
            if let fahrenheitValue = Double(text){
                let celsiusValue = 5.0/9.0*(fahrenheitValue - 32.0)
                celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
                
            }else{
                celsiusLabel.text = "???"
                
            }
        }
    }
    
}
extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existing = textField.text?.firstIndex(of: ".")
        
        let comming = string.firstIndex(of: ".")
        
        if let _ = existing, let _ = comming{
            return false
        }
        return true
    }
}

class MyDelegate: NSObject, UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existing = textField.text?.firstIndex(of: ".")
        
        let comming = string.firstIndex(of: ".")
        
        if let _ = existing, let _ = comming{
            return false
        }
        return true
    }
    
}
