//
//  Plan.swift
//  ch09-leejaemoon-tableView
//
//  Created by jmlee on 2023/04/26.
//

import Foundation
import Firebase
class Record: NSObject /*, NSCoding*/{
    var key: String;
    var latitude: Double
    var longitude: Double
    var name: String
    var category: String
    var date: Date
    
    init(date: Date, latitude: Double, longitude: Double, name: String, category: String){
        self.key = UUID().uuidString   // 거의 unique한 id를 만들어 낸다.
        self.date = Date(timeInterval: 0, since: date)

        self.name = name
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
        
        
        super.init()
    }
}

extension Record{
    func clone() -> Record {
        let clonee = Record(date: <#Date#>, latitude: <#Double#>, longitude: <#Double#>, name: <#String#>, category: <#String#>)

        clonee.key = self.key    // key는 String이고 String은 struct이다. 따라서 복제가 된다
        clonee.date = Date(timeInterval: 0, since: self.date) // Date는 struct가 아니라 class이기 때문
        clonee.name = self.name
        clonee.category = self.category
        clonee.latitude = self.latitude
        clonee.longitude = self.longitude
        
        return clonee
    }
    func toDict() -> [String: Any?] {
        var dict: [String: Any?] = [:]

        dict["key"] = key
        dict["date"] = Timestamp(date: date)
        dict["name"] = name
        dict["category"] = category
        dict["latitude"] = latitude
        dict["longitude"] = longitude
        
        return dict
    }

    func toRecord(dict: [String: Any?]) {
        key = dict["key"] as! String
        date = Date()
        if let timestamp = dict["date"] as? Timestamp {
            date = timestamp.dateValue()
        }
        name = dict["name"] as! String
        category = dict["category"] as! String
        
        longitude = dict["longitude"] as! Double
        latitude = dict["latitude"] as! Double
    }
}
