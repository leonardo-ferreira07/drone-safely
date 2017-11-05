//
//  DataHelper.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 05/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataHelper {
    
    static let shared = DataHelper()
    
    var databaseRef: DatabaseReference!
    
    private init() {
        databaseRef = Database.database().reference()
    }
    
}
