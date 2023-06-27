//
//  WebViewController.swift
//  sunghoon_Ios_programming_week_6
//
//  Created by Capstone on 2023/04/10.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController{
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var textfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let parent = self.parent as! UITabBarController
        let cityViewController = parent.viewControllers![0] as! CityViewController
        
        let (city, _, _) = cityViewController.getCurrentLonLat()
        
        textfield.text = city
    }
    
    @IBAction func querybutton(_ sender: Any) {
        let apiKey = "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"
        let site = "https://api.openai.com/v1/engines/curie/completions"
        
        let parameters: [String: Any] = [
            "prompt": "\(textfield.text!)",
            "temperature": 0.5,
            "max_tokens": 500
        ]
        
        guard let url = URL(string: site) else {
            print("Invalid API endpoint URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard let jsonData = data else {print(error!); return }
            if let jsonStr = String(data: jsonData, encoding: .utf8){
                print(jsonStr)
            }
            
            let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            guard let choices = json["choices"] as? [[String: Any]], let text = choices.first?["text"] as? String else {
                print("Invalid response data")
                return
            }
            
            DispatchQueue.main.async {
                self.textview.text = text
            }
            
            
        }
        task.resume()
    }
    
}
    

