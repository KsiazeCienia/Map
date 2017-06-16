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
}
