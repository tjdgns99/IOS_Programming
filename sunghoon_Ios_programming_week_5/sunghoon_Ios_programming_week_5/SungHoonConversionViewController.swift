//
//  ViewController.swift
//  sunghoon_Ios_programming_week_5
//
//  Created by Capstone on 2023/04/03.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit

class SungHoonConversionViewController: UIViewController {

    var fahrenheitTextField: UITextField!
    var celsiusLabel: UILabel!
    var isLabel, fdegreeLabel, cdegreeLabel: UILabel!
    
    var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let helloLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 30))
//        helloLabel.text="Hello, Autolayout"
//        helloLabel.backgroundColor = UIColor.green
//        helloLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        helloLabel.textAlignment = .center
//        view.addSubview(helloLabel)
        
//        helloLabel.translatesAutoresizingMaskIntoConstraints = false
//        let centerXConstraint = helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
//        let centerYConstraint = helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 0)
//
//
//        //view.addSubview(helloLabel)
//        centerXConstraint.isActive = true
//        centerYConstraint.isActive = true
//        view.addSubview(helloLabel)
        
        
//        helloLabel.translatesAutoresizingMaskIntoConstraints = false
//        helloLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        helloLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
//        view.addSubview(helloLabel)
        
        
//        helloLabel.translatesAutoresizingMaskIntoConstraints = false
//        helloLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        helloLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
//        helloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
//        view.addSubview(helloLabel)
        
//        helloLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            helloLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            helloLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            helloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
//        ]);
//        view.addSubview(helloLabel)
        
//        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        nameLabel.text = "Name"
//        nameLabel.backgroundColor = UIColor.green
//        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        nameLabel.textAlignment = .center
//
//        let nameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        nameTextField.backgroundColor = UIColor.brown
//        nameTextField.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        nameTextField.textAlignment = .left
//
//        view.addSubview(nameLabel)
//        view.addSubview(nameTextField)
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameTextField.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            nameLabel.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -10),
//            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
//        ]);
//
//        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
//
//        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        nameTextField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
//
//        nameTextField.keyboardType = .decimalPad
//
//        nameTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        //editingDidEnd이 끝났다는 것을 UITextField에 알리기 위해
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGesture)
        
        
        //var segmentedControl: UISegmentedControl!
        
        isLabel = createLabel(text: "is", fontSize: 36)
        isLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        isLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
//        fahrenheitTextField.bottomAnchor.constraint(equalTo: fdegreeLabel.topAnchor, constant: 8).isActive = true
        
//        fahrenheitTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        
//        let isLabel = createLabel("is", fontSize: 36)
        isLabel.translatesAutoresizingMaskIntoConstraints = false
        isLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        isLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        fahrenheitTextField = createTextField(placeHolder: "VALUE")
        fdegreeLabel = createLabel(text: "degrees Fahrenheit", fontSize: 36)
        celsiusLabel = createLabel(text: "???", fontSize: 70)
        cdegreeLabel = createLabel(text: "degrees Celisius", fontSize: 36)
        
        connectVertically(views: fahrenheitTextField, fdegreeLabel, isLabel, celsiusLabel, cdegreeLabel, spacing: 10)
        connectHorizontally(views: fahrenheitTextField, fdegreeLabel, isLabel, celsiusLabel, cdegreeLabel)
        
        fahrenheitTextField.addTarget(self, action: #selector(fahrenheitEditingChanged), for: .editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        fahrenheitTextField.delegate = self
        
        addSegmentedControl()
    }
//    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
//        view.endEditing(true)
//    }
    @objc func editingDidEnd(sender: UITextField){
        if let text = sender.text, let fahreheitValue = Double(text) {
            sender.text = String.init(format:  "%2f", (5.0/9.0)*(fahreheitValue - 32.0))
        }
    }
}

extension SungHoonConversionViewController{
    func createTextField(placeHolder: String) -> UITextField{
        let textField = UITextField(frame: CGRect())
        textField.textAlignment = .center
        textField.placeholder = placeHolder
        textField.font = UIFont(name: textField.font!.fontName, size: 70)
        textField.keyboardType = .decimalPad
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func createLabel(text:String, fontSize: CGFloat) -> UILabel{
        let label = UILabel(frame: CGRect())
        label.text = text
        label.textColor = UIColor(red: CGFloat(0xe1)/CGFloat(256), green: CGFloat(0x58)/CGFloat(256), blue: CGFloat(0x29)/CGFloat(256), alpha: CGFloat(1))
        label.textAlignment = .center
        label.font = UIFont(name: label.font!.fontName, size: fontSize)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    func connectVertically(views: UIView..., spacing: CGFloat){
        for i in 0..<views.count - 1{
            views[i].bottomAnchor.constraint(equalTo: views[i+1].topAnchor, constant: spacing).isActive = true
        }
    }
    func connectHorizontally(views: UIView...){
        for view in views{
            view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
    }
}
extension SungHoonConversionViewController{
    @objc func fahrenheitEditingChanged(sender: UITextField){
        if let text = sender.text{
            if let fahrenheitValue = Double(text){
                if(segmentedControl.selectedSegmentIndex == 0){
                    let celsiusValue = 5.0/9.0*(fahrenheitValue - 32.0)
                    celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
                }else {
                    let celsiusValue = 9.0/5.0*(fahrenheitValue + 32.0)
                    celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
                }
            }else {
                celsiusLabel.text = "???"
            }
        }
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        fahrenheitTextField.resignFirstResponder()
    }
}

extension SungHoonConversionViewController: UITextFieldDelegate{
    func textField( textField: UITextField, shouldChageCharactersln range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if(existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil){
            return false
        }else{
            return true
        }
    }
}

extension SungHoonConversionViewController{
    func addSegmentedControl(){
        segmentedControl = UISegmentedControl(items: ["Fahrenheit", "Celsius"])
        let font = UIFont.systemFont(ofSize: 20)
        segmentedControl!.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        segmentedControl.addTarget(self, action: #selector(changeDegrees), for: .valueChanged)
    }
}

extension SungHoonConversionViewController{
    @objc func changeDegrees(sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            fdegreeLabel.text = "degrees Fahrenheit"
            cdegreeLabel.text = "degrees Celsius"
        }else{
            fdegreeLabel.text = "degrees Celsius"
            cdegreeLabel.text = "degrees Fahrenheit"
        }
        fahrenheitTextField.text = ""
        celsiusLabel.text = "???"
    }
}


