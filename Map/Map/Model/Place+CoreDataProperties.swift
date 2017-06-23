//
//  Place+CoreDataProperties.swift
//
//  Created by Marcin on 23.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//
//

import Foundation
import CoreData


extension Place {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }
    
    @nonobjc public class func fetchRequestForLast(withId id: Int) -> NSFetchRequest<Place> {
        let fetch = NSFetchRequest<Place>(entityName: "Place")
        fetch.predicate = NSPredicate(format: "id == %d", id )
        return fetch
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var imagePath: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var name: String?
    
}
