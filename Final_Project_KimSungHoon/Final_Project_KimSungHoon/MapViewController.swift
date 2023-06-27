import UIKit
import Foundation
import MapKit
import CoreLocation
import Firebase

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var position: [String: Double?] = ["lon": nil, "lat": nil]
    var locationManager = CLLocationManager()

    struct Restaurant: Codable {
        let latitude: Double
        let longitude: Double
        let name: String
        let category: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("현재 위치 지도에 표시")

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            print("위치 서비스 허용 off")
        }
        mapView.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            position["lon"] = location.coordinate.longitude
            position["lat"] = location.coordinate.latitude
            print("현재위치")
        }

        let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        let latitude = position["lat"]
        let longitude = position["lon"]
        let location = "\(latitude!!),\(longitude!!)"
        print(location)
        let radius = 10000
        let apiKey = "구글 API 키로 바꿔야됨" // 자신의 Google Maps API 키로 대체해야 합니다.

        let types = "restaurant"
        let urlString = "\(baseURL)?location=\(location)&radius=\(radius)&types=\(types)&key=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(PlacesResult.self, from: data)

                let restaurants = result.results.compactMap { place -> Restaurant? in
                    let foodTypes = ["restaurant", "cafe", "bakery", "meal_delivery", "meal_takeaway", "bar", "food"]
                    if place.types.contains(where: { foodTypes.contains($0) }) {
                        return Restaurant(latitude: place.geometry.location.latitude,
                                          longitude: place.geometry.location.longitude,
                                          name: place.name,
                                          category: place.types.first ?? "")
                    } else {
                        return nil
                    }
                }

                print("맛집 리스트")
                print(restaurants.count)
                for restaurant in restaurants {
                    print("Name: \(restaurant.name)")
                    print("Category: \(restaurant.category)")
                    print("Latitude: \(restaurant.latitude)")
                    print("Longitude: \(restaurant.longitude)")
                    print("----------")

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
                    annotation.title = restaurant.name
                    self.mapView.addAnnotation(annotation)
                }
                print("끝")

            } catch {
                print("JSON decoding error: \(error)")
            }
        }.resume()

        updateMap(title: "현재위치", longitude: position["lon"]!, latitude: position["lat"]!)
    }

    func updateMap(title: String, longitude: Double?, latitude: Double?) {
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        var center = mapView.centerCoordinate
        if let longitude = longitude, let latitude = latitude {
            center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation,
           let title = annotation.title {
            print("선택한 마커: \(title) 검색")
            
            // Firestore 문서 레퍼런스 생성
            let db = Firestore.firestore()
            let documentRef = db.collection("Restaurants").document()
                    
            // 저장할 데이터 생성
            let data: [String: Any] = [
                "name": title,
                "latitude": annotation.coordinate.latitude,
                "longitude": annotation.coordinate.longitude
                // 필요한 다른 키-값 쌍 추가
            ]
                    
            // Firestore에 데이터 저장
            documentRef.setData(data) { error in
                if let error = error {
                    print("데이터 저장 오류: \(error)")
                } else {
                    print("데이터 저장 성공!")
                }
            }
            

            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                detailViewController.markerTitle = title
                detailViewController.lat = annotation.coordinate.latitude
                detailViewController.lon = annotation.coordinate.longitude
                print("DetailViewController로 이동")
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
}
