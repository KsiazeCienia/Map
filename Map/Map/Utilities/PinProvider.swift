//
//  PinProvider.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class PinProvider {
    
    let apiManager = APIManager()
    
    func getPinsFromAPI(lng: Double, lat: Double, succesHandler:@escaping (_ pins: [Pin]?) -> Void, errorHandler:@escaping (_ apiError: APIError) -> Void  ) {
        
        apiManager.getPins(lat: lat, lng: lng) { (result) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    errorHandler(error)
                }
            case .Success(result: let response):
                DispatchQueue.main.async {
                    let pins = response.map{ Pin(withDictionar: $0) }
                    succesHandler(pins)
                }
            }
        }
    }
}
