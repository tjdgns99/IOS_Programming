//
//  PlacesResult.swift
//  Final_Project_KimSungHoon
//
//  Created by Capstone on 2023/06/14.
//

import Foundation
struct PlacesResult: Codable {
    let results: [Place]
    
    struct Place: Codable {
        let geometry: Geometry
        let name: String
        let types: [String]
        
        struct Geometry: Codable {
            let location: Location
            
            struct Location: Codable {
                let latitude: Double
                let longitude: Double
                
                enum CodingKeys: String, CodingKey {
                    case latitude = "lat"
                    case longitude = "lng"
                }
            }
        }
    }
}

