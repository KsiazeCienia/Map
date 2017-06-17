//
//  DataBase.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation
import RealmSwift

final class DataBase {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- TODO sprawdzanie czy coś jest już w bazie danych
    func save(pin: Pin) {
        let place = Place(context: context)
        place.name = pin.name
        place.id = Int64(pin.id)
        place.lat = pin.lat
        place.lng = pin.lng
        place.imagePath = pin.imagePath
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
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


