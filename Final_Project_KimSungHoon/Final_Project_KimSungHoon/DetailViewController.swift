//
//  DetailViewController.swift
//  Final_Project_KimSungHoon
//
//  Created by Capstone on 2023/06/15.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var markerTitle: String?
    var lon: Double?
    var lat: Double?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("식당 상세 내역")
        
        webView.navigationDelegate = self
        
        if let markerTitle = markerTitle {
            let encodedMarkerTitle = markerTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let urlString = "https://www.mangoplate.com/search/\(encodedMarkerTitle ?? "")"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
                print("웹뷰 그리기")
            } else {
                print("Invalid URL")
            }
        } else {
            print("No marker title")
        }



    }
    
    // 웹뷰의 페이지 로드가 시작될 때 호출되는 메서드
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // 로딩 시작 시 로딩 인디케이터 등을 표시할 수 있습니다.
    }
    
    // 웹뷰의 페이지 로드가 완료될 때 호출되는 메서드
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 로딩이 완료되었으므로 로딩 인디케이터 등을 숨길 수 있습니다.
    }
    
    // 웹뷰의 페이지 로드 중 에러가 발생할 때 호출되는 메서드
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 에러 처리를 수행할 수 있습니다.
    }
    
    // ...
}

