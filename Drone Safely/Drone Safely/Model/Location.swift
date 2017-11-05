//
//  Location.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 05/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import Foundation

struct Location {
    let locationName: String
    let locationDescription: String
    let latitude: Double
    let longitude: Double
    
    // MARK: - Object as Dictionary
    
    func toDictionary() -> [String: Any] {
        return ["locationName": locationName,
        "locationDescription": locationDescription,
        "latitude": latitude,
        "longitude": longitude]
    }
    
}
