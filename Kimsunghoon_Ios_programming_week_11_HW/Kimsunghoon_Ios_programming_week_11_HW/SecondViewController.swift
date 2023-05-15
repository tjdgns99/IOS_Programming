//
//  SecondViewController.swift
//  Kimsunghoon_Ios_programming_week_11_HW
//
//  Created by Capstone on 2023/05/15.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    
    var text: String?
    
    var saveChangeDelegate: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.text = text
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        saveChangeDelegate!(textfield.text!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
