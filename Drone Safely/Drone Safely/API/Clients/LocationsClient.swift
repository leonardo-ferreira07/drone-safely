//
//  LocationsClient.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 05/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct LocationsClient {
    
    static func postNewLocation(_ location: Location) {
        DataHelper.shared.databaseRef.child("locations").childByAutoId().setValue(location.toDictionary())
    }
    
    static func getLocations(completion: @escaping ([Location]) -> Void) {
        let recentLocationsQuery = DataHelper.shared.databaseRef.child("locations").queryLimited(toFirst: 500)
        var locations: [Location] = []
        recentLocationsQuery.observe(.value, with:{ (snapshot: DataSnapshot) in
            for snap in snapshot.children {
                if let snap = snap as? DataSnapshot {
                    if let locationDict = snap.value as? [String: Any] {
                        locations.append(Location.init(withDictionary: locationDict))
                    }
                }
            }
            completion(locations)
            print(locations)
        })
    }
}
