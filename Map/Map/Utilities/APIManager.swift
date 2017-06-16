//
//  APIManager.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class APIManager {
    
    fileprivate let apiClient = APIClient()
    
    func getPins(withURL url: URL, completion: @escaping ResultBlock<[[String:Any]]>) {
        apiClient.GETRequest(withURL: url) {
            (result: Result<[[String:Any]]>) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    completion(Result.Error(error: error))
                }
            case .Success(result: let response):
                DispatchQueue.main.async {
                    completion(Result.Success(result: response))
                }
            }
            
        }
    }
    
}
