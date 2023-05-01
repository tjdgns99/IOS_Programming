//
//  ViewController.swift
//  sunghoon_Ios_programming_week_6
//
//  Created by Capstone on 2023/04/10.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityPickerview: UIPickerView!
    var cities: [String: [String:Double?]] = ["Seoul" : ["lon":126.9778,"lat":37.5683], "Athens" : ["lon":23.7162,"lat":37.9795], "Bangkok" : ["lon":100.5167,"lat":13.75], "Berlin" : ["lon":13.4105,"lat":52.5244], "Jerusalem" : ["lon":35.2163,"lat":31.769], "Lisbon" :  ["lon":-9.1333,"lat":38.7167], "London" : ["lon":-0.1257,"lat":51.5085], "New York" :  ["lon":-74.006,"lat":40.7143], "Paris" :  ["lon":2.3488,"lat":48.8534], "Sydney" :  ["lon":151.2073,"lat":-33.8679], "현재위치" :
        ["lon": nil, "lat": nil]
        
    ]
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityPickerview.dataSource = self
        cityPickerview.delegate = self
        
        locationManager.delegate = self
        // 거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
        // 위치 사용을 허용하면 현재 위치 정보를 가져옴
        if CLLocationManager.locationServicesEnabled() {
           locationManager.startUpdatingLocation()
        }
        else {
            print("위치 서비스 허용 off")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            cities["현재위치"]?["lon"] = location.coordinate.longitude
            cities["현재위치"]?["lat"] = location.coordinate.latitude
        
        }
    }
        
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}

extension CityViewController: UIPickerViewDataSource, UIPickerViewDelegate{
            func numberOfComponents(in pickerView: UIPickerView) -> Int {
                        return 1
                }
            func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                        let cityNames = Array(cities.keys)
                        return cityNames.count
                }
            func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                        var cityNames = Array(cities.keys)
                        cityNames.sort()
           
                        return cityNames[row]
                }
}

extension CityViewController{
        func getCurrentLonLat() -> (String, Double??, Double??){
        
        var cityNames = Array(cities.keys)
        cityNames.sort()
        let selectedCity = cityNames[cityPickerview.selectedRow(inComponent: 0)]
        let city = cities[selectedCity]
        return (selectedCity, city!["lon"], city!["lat"])
    }
}
