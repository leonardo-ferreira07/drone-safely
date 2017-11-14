//
//  LocationsClient.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 05/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

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
                    if var locationDict = snap.value as? [String: Any] {
                        locationDict[LocationKeys.key.rawValue] = snap.key
                        locations.append(Location.init(withDictionary: locationDict))
                    }
                }
            }
            recentLocationsQuery.removeAllObservers()
            completion(locations)
            print(locations)
        })
    }
    
    static func postNewReview(withKey key: String, text: String) {
        DataHelper.shared.databaseRef.child("locations/\(key)/reviews").childByAutoId().setValue(text)
    }
    
    static func getReviews(withKey key: String, completion: @escaping ([String]) -> Void) {
        let recentReviewsQuery = DataHelper.shared.databaseRef.child("locations/\(key)/reviews").queryLimited(toFirst: 500)
        var reviews: [String] = []
        recentReviewsQuery.observe(.value, with:{ (snapshot: DataSnapshot) in
            for snap in snapshot.children {
                if let snap = snap as? DataSnapshot {
                    if let locationDict = snap.value as? String {
                        reviews.append(locationDict)
                    }
                }
            }
            recentReviewsQuery.removeAllObservers()
            completion(reviews)
            print(reviews)
        })
    }
}
