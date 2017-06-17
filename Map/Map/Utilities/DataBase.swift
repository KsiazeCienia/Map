//
//  DataBase.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation
import RealmSwift

class DataBase {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(pin: Pin) {
        let place = Place(context: context) // Link Task & Context
        place.name = pin.name
        place.id = Int64(pin.id)
        place.lat = pin.lat
        place.lng = pin.lng
        place.imagePath = pin.imagePath
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //let _ = navigationController?.popViewController(animated: true)
    }
    
    func getData() {
        var places = [Place]()
        
        do {
            places = try context.fetch(Place.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        
        
    }
    
    private func parsePlace(places: [Place]) {
        var pins = [Pin]()
        
        for place in places {
            //let pin = Pin(
        }
    }
}


