//
//  ViewController.swift
//  sunghoon_Ios_programming_week_5
//
//  Created by Capstone on 2023/04/03.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameLabel.text = "Name"
        nameLabel.backgroundColor = UIColor.green
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.textAlignment = .center
        
        let nameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameTextField.backgroundColor = UIColor.brown
        nameTextField.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameTextField.textAlignment = .left
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ]);
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        nameTextField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        //editingDidEnd 액션 추가
        
        nameTextField.keyboardType = .decimalPad
        
        nameTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        //editingDidEnd이 끝났다는 것을 UITextField에 알리기 위해
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func editingDidEnd(sender: UITextField){
        if let text = sender.text, let fahreheitValue = Double(text) {
            sender.text = String.init(format:  "%2f", (5.0/9.0)*(fahreheitValue - 32.0))
        }
    }
}
