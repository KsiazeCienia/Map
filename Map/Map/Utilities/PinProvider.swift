//
//  PinProvider.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class PinProvider {

    fileprivate let apiClient = APIClient()
    
    func getPinsFromAPI(lng: Double, lat: Double, succesHandler:@escaping (_ pins: [Pin]?) -> Void, errorHandler:@escaping (_ apiError: APIError) -> Void  ) {
        
        let url = URLBuilder.pinsURL(withLat: lat, withLng: lng)
        
        apiClient.GETRequest(withURL: url) {
            (result: Result<[[String:Any]]>) in
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
