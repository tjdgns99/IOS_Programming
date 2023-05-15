//
//  ViewController.swift
//  Kimsunghoon_Ios_programming_week_11_HW
//
//  Created by Capstone on 2023/05/15.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func present(_ sender: UIButton) {
        let firstViewController = storyboard?.instantiateViewController(withIdentifier: "second") as? SecondViewController
        
        
        if let viewController = firstViewController{
            viewController.text = textfield.text
            viewController.saveChangeDelegate = saveChange
            present(viewController, animated: true, completion: nil)
        }


    }
    
    @IBAction func present_nav(_ sender: UIButton) {
        let secondViewController = storyboard?.instantiateViewController(withIdentifier: "second") as? SecondViewController
        
        if let viewController = secondViewController{
            viewController.text = textfield.text
            viewController.saveChangeDelegate = saveChange
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    @IBAction func perform(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Second", sender: self)
    }
}

extension FirstViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "Second"{
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.text = textfield.text
            secondViewController.saveChangeDelegate = saveChange
        }
        
        
    }
}

extension FirstViewController{
    func saveChange(text: String?){
        textfield.text = text
    }
}
