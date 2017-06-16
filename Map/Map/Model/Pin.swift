//
//  Pin.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class Pin {
    
    let id: Int
    let lng: Float
    let lat: Float
    let name: String
    let imagePath: String
    
    init(id: Int, lng: Float, lat: Float, name: String, imagePath: String) {
        self.id = id
        self.lng = lng
        self.lat = lat
        self.name = name
        self.imagePath = imagePath
    }
    
    init(withDictionar pinDict: [String:Any])   {
        id = pinDict[APIKeys.id] as? Int ?? 0
        name = pinDict[APIKeys.name] as? String ?? ""
        lat = pinDict[APIKeys.lat] as? Float ?? 0
        lng = pinDict[APIKeys.lng] as? Float ?? 0
        imagePath = pinDict[APIKeys.avatar] as? String ?? ""
    }    
}
