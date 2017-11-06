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
    var keyIdentifier: String = ""
    
    // MARK: - Init with Dictionary
    
    init(locationName: String, locationDescription: String, latitude: Double, longitude: Double) {
        self.locationName = locationName
        self.locationDescription = locationDescription
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(withDictionary dictionary: [String: Any]) {
        self.locationName = ParserHelper.getString(from: dictionary[LocationKeys.locationName.rawValue])
        self.locationDescription = ParserHelper.getString(from: dictionary[LocationKeys.locationDescription.rawValue])
        self.latitude = ParserHelper.getDouble(from: dictionary[LocationKeys.latitude.rawValue])
        self.longitude = ParserHelper.getDouble(from: dictionary[LocationKeys.longitude.rawValue])
        self.keyIdentifier = ParserHelper.getString(from: dictionary[LocationKeys.key.rawValue])
    }
    
    // MARK: - Object as Dictionary
    
    func toDictionary() -> [String: Any] {
        return [LocationKeys.locationName.rawValue: locationName,
        LocationKeys.locationDescription.rawValue: locationDescription,
        LocationKeys.latitude.rawValue: latitude,
        LocationKeys.longitude.rawValue: longitude]
    }
    
}

enum LocationKeys: String {
    case locationName
    case locationDescription
    case latitude
    case longitude
    case key
}
