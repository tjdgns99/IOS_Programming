//
//  User_ViewController.swift
//  Ios_program_week_3
//
//  Created by Capstone on 2023/03/20.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit
class User_ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
        let firstView = UIView(frame: firstFrame)
        firstView.backgroundColor = UIColor.blue
 
        view.addSubview(firstView)
        
        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
        let secondView = UIView(frame: secondFrame)
        secondView.backgroundColor = UIColor.green
         
        view.addSubview(secondView)
        
    }
}
