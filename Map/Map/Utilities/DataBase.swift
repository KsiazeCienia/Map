//
//  DataBase.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit
import CoreData


final class DataBase {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(pin: Pin) {
        if !contains(id: pin.id) {
            let place = Place(context: context)
            place.name = pin.name
            place.id = Int64(pin.id)
            place.lat = pin.lat
            place.lng = pin.lng
            place.imagePath = pin.imagePath
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
    
    func contains(id: Int) -> Bool {
        var places = [Place]()
        do {
            places = try context.fetch(Place.fetchRequestForLast(withId: id))
        } catch {
            print("Fetching Failed")
        }
        return !places.isEmpty
    }
    
    func getData() -> [Pin] {
        var places = [Place]()
        
        do {
            places = try context.fetch(Place.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        return parsePlace(places: places)
    }
    
    private func parsePlace(places: [Place]) -> [Pin] {
        var pins = [Pin]()
        
        for place in places {
            guard let actualName = place.name else { continue }
            guard let actualImagePath = place.imagePath else { continue }
            let pin = Pin(id: Int(place.id), lng: place.lng, lat: place.lat, name: actualName, imagePath: actualImagePath)
            pins.append(pin)
        }
        return pins
    }
}


