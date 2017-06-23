//
//  Annotation.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import MapKit

class Annotation: MKPointAnnotation {
    var id: Int?
    
    init(id: Int, coordinate: CLLocationCoordinate2D, title: String) {
        super.init()
        self.id = id
        self.coordinate = coordinate
        self.title = title
    }
}

