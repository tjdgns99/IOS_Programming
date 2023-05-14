//
//  SelectContentViewController.swift
//  Kimsunghoon_Ios_programming_week_10
//
//  Created by Capstone on 2023/05/08.
//  Copyright © 2023 Capstone. All rights reserved.
//

import UIKit

class SelectContentViewController: UIViewController, UITableViewDelegate {
    
    var plan: Plan?
    var planGroup: PlanGroup!
    var saveChangeDelegate: ((Plan) -> Void)?
    
    @IBOutlet weak var selectContentTableView: UITableView!
    
    var planDetailViewController: PlanDetailViewController?
    
    let contents = [
    "엄마 도와드리기",
    "아르바이트",
    "청소하기",
    "학교 가서 밥 먹기",
    "ios 즐겁게 숙제하기",
    "친구와 카페가기",
    "데이트 하기"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        selectContentTableView.dataSource = self
        selectContentTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectContent(_ sender: UIButton) {
        planDetailViewController?.contentTextView.text = planDetailViewController?.plan?.content
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unselectContent(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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

extension SelectContentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(contents.count)
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
     
        // planGroup는 대략 1개월의 플랜을 가지고 있다. 그중에서 선택된 날짜의 데이터만 테이블에 보인다.
        let content = contents[indexPath.row]

        (cell.contentView.subviews[0] as! UILabel).text = content
        print("cell complete")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //클릭한 셀의 이벤트 처리
        
        print("Click Cell Number: " + String(indexPath.row))
        print("Click Cell Value1: " + contents[indexPath.row])
        
        planDetailViewController?.contentTextView.text = contents[indexPath.row]
        print(planDetailViewController?.contentTextView.text)
        
    }
}
