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
                
                updateMap(title: city, longitute: longitute!!, latitute: latitute!!)
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



extension MapViewController{
      
            override func viewWillDisappear(_ animated: Bool) {
                        mapView.removeAnnotations(mapView.annotations)
                }
}

extension MapViewController{
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
