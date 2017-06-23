//
//  URLBuilder.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//
import Foundation

final class URLBuilder {

    static func pinsURL(withLat lat: Double, withLng lng: Double) -> URL {
        let urlString = "https://interview-ready4s.herokuapp.com/geo?lat=\(String(lat))&lng=\(String(lng))"
        return URL(string: urlString)!
    }
}
