//
//  WebViewController.swift
//  sunghoon_Ios_programming_week_6
//
//  Created by Capstone on 2023/04/10.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let parent = self.parent as! UITabBarController
        let cityViewController = parent.viewControllers![0] as! CityViewController
        var (city, nouse, nouse2) = cityViewController.getCurrentLonLat()
        
        if city == "현재위치"{
            city = ""
        }
        let urlStr = "https://en.wikipedia.org/wiki/" + city
        
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        
    }
    
    
    
}

