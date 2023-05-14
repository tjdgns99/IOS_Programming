//
//  MapViewController.swift
//  sunghoon_Ios_programming_week_6
//
//  Created by Capstone on 2023/04/10.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBAction func sgcValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
                        case 0:
                                            mapView.mapType = .standard
                        case 1:
                                            mapView.mapType = .hybrid
                        case 2:
                                            mapView.mapType = .satellite
                        default:
                                            break
                        }
        
    }
    @IBOutlet weak var mapView: MKMapView!
    let baseURLString = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "apikey"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController.viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
                                    print("MapViewController.viewWillAppear")
        let parent = self.parent as! UITabBarController
                    let cityViewController = parent.viewControllers![0] as! CityViewController
                    let (city, longitute, latitute) = cityViewController.getCurrentLonLat()
                    
        
        getWeatherData(cityName: city)  //날씨 가져오기, 7주차
        //updateMap(title: city, longitute: longitute latitute: latitute)
                    //updateMap(title: city, longitute: longitute!!, latitute: latitute!!)
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



extension MapViewController{
    
                override func viewWillDisappear(_ animated: Bool) {
                                    mapView.removeAnnotations(mapView.annotations)
                    }
}

extension MapViewController{
                func updateMap(title: String, longitute: Double?, latitute: Double?){
        
                                    let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                                    var center = mapView.centerCoordinate // 일단 기존의 중심을 저장
                                    if let longitute = longitute, let latitute = latitute{
                                                        center = CLLocationCoordinate2D(latitude: latitute, longitude: longitute) // 새로운 중심 설정
                                        }
                                    let region = MKCoordinateRegion(center: center, span: span)
                                    mapView.setRegion(region, animated: true) // 주어진 영역으로 지도를 설정
                                    
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = center // 센터에 annotation을 설치
                                    annotation.title = title
                                    mapView.addAnnotation(annotation)
                    }
}

import Progress
extension MapViewController {
    func getWeatherData(cityName city: String){
        Prog.start(in: self, .activityIndicator)
        var urlStr = baseURLString+"?"+"q="+city+"&"+"appid="+apiKey
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //특수문자가 못들어가므로 쿼리에 맞는 형태로 인코딩하기위해서 addingPercentEncoding 사용
        let session = URLSession(configuration: .default)
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            guard let jsonData = data else { print(error!); return}//guard: if let(null이 아니면 실행)하고 반대되는 개념, guard let(null이면 실행)
            if let jsonStr = String(data:jsonData, encoding: .utf8){
                print(jsonStr)
            }
            
            let (temperature, longitute, latitude) = self.extractWeatherData(jsonData: jsonData)
            var title = city
            if let temperature = temperature{
                title += String.init(format: ": %.2f도", temperature)
            }
            DispatchQueue.main.async() { //sync면 1, 2 출력, 1이 실행되는 것을 기다려줌
                self.updateMap(title: title, longitute: longitute, latitute: latitude)
                Prog.dismiss(in: self)
                print("1")
            }
            print("2")
            
        }
        dataTask.resume()
        
    }
}

extension MapViewController {
            func extractWeatherData(jsonData: Data) -> (Double?, Double?, Double?){
                        
                        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
          
                        // {"cod":"404","message":"city not found"} for unknown city
                        if let code = json["cod"] {
                                    if code is String, code as! String == "404"{
                                                return (nil, nil, nil)
                                        }
                            }
                        
                        let latitude = (json["coord"] as! [String: Double])["lat"]
                        let longitude = (json["coord"] as! [String: Double])["lon"]
                        
                        guard var temperature = (json["main"] as! [String: Double])["temp"] else{
                                    return (nil, longitude, latitude)
                            }
                        temperature = temperature - 273.0
                        return (temperature, longitude, latitude)
                }
}
