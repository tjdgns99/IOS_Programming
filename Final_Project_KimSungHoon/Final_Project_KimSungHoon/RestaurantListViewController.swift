import UIKit
import Firebase

class RestaurantListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var restaurants: [Restaurant] = []
    var db: Firestore!
            
    struct Restaurant {
        let id: String
        let name: String
        let latitude: Double
        let longitude: Double
                
        init(id: String, data: [String: Any]) {
            self.id = id
            self.name = data["name"] as? String ?? ""
            self.latitude = data["latitude"] as? Double ?? 0.0
            self.longitude = data["longitude"] as? Double ?? 0.0
        }
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Firestore 초기화
        db = Firestore.firestore()
                
        // Firestore에서 식당 목록 가져오기
        fetchRestaurants()
                
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRestaurants()
    }

            
    @IBAction func showMapView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
    func fetchRestaurants() {
        db.collection("Restaurants").getDocuments { [weak self] (snapshot, error) in
            guard let snapshot = snapshot else {
                print("데이터 가져오기 오류: \(error?.localizedDescription ?? "")")
                return
            }
            
            var restaurants: [Restaurant] = []
            for document in snapshot.documents {
                let data = document.data()
                let restaurant = Restaurant(id: document.documentID, data: data)
                restaurants.append(restaurant)
            }
            
            self?.restaurants = restaurants
            self?.tableView.reloadData() // 테이블 뷰 데이터 리로드 추가
        }
    }
}

extension RestaurantListViewController: UITableViewDataSource, UITableViewDelegate {
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell
            
        let restaurant = restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
            
        return cell
    }
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = restaurants[indexPath.row]
            
        // 선택한 식당에 대한 추가 동작 수행
        // 예를 들어, 상세 정보 표시 등
                
        // 예시로 상세 정보를 콘솔에 출력
        print("선택한 식당: \(restaurant.name)")
        print("위도: \(restaurant.latitude)")
        print("경도: \(restaurant.longitude)")
        
        // 다른 동작을 수행하도록 수정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as?      DetailViewController {
            detailViewController.markerTitle = restaurant.name
            detailViewController.lat = restaurant.latitude
            detailViewController.lon = restaurant.longitude
            print(detailViewController.markerTitle!)
            print("웹으로 이동")
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
