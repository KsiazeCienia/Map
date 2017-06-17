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
    
    func save(pin: Pin) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(pin)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
