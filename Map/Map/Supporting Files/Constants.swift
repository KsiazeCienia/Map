//
//  Constants.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

struct APIKeys {
    static let id = "id"
    static let name = "name"
    static let lng = "lng"
    static let lat = "lat"
    static let avatar = "avatar"
}

enum HTTPMethods: String {
    case GET = "GET"
}

struct MapKeys {
    static let latitudeDelta = 0.05
    static let longitudeDelta = 0.05
}
