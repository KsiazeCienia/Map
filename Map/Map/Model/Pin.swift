//
//  Pin.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation
import RealmSwift

class Pin {
    
    let id: Int
    let lng: Double
    let lat: Double
    let name: String
    let imagePath: String
    
    init(id: Int, lng: Double, lat: Double, name: String, imagePath: String) {
        self.id = id
        self.lng = lng
        self.lat = lat
        self.name = name
        self.imagePath = imagePath
    }
    
    init(withDictionar pinDict: [String:Any])   {
        let numberInString = pinDict[APIKeys.id] as? String ?? ""
        if let actualId = Int(numberInString) {
            id = actualId
        } else {
            id = 0
        }
        name = pinDict[APIKeys.name] as? String ?? ""
        lat = pinDict[APIKeys.lat] as? Double ?? 0
        lng = pinDict[APIKeys.lng] as? Double ?? 0
        imagePath = pinDict[APIKeys.avatar] as? String ?? ""
    }
}


