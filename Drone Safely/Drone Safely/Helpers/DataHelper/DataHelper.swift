//
//  DataHelper.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 05/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import Firebase
import FirebaseDatabase

class DataHelper {
    
    static let shared = DataHelper()
    
    var databaseRef: DatabaseReference!
    
    private init() {
        Database.database().isPersistenceEnabled = true
        databaseRef = Database.database().reference()
    }
    
}
