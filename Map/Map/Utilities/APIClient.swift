//
//  APIClient.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

final class APIClient {
    
    enum HTTPMethods: String {
        case GET = "GET"
    }
    
    func GETRequest(withURL url: URL, completion: @escaping ResultBlock<[[String: Any]]>) {
        let (request, session) = configuration(forURL: url, httpMethod: HTTPMethods.GET.rawValue)
        session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(Result.Error(error: APIError.unexpectedError))
                return
            }
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(Result.Error(error: APIError.noData))
                return
            }
            guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
                completion(Result.Error(error: APIError.wrongHTTPCode(code: httpResponse.statusCode)))
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                completion(Result.Error(error: APIError.jsonSerializationFailed))
                return
            }
            if let jsonDict = jsonData as? [String: Any] {
                let jsonArray = [jsonDict]
                completion(Result.Success(result: jsonArray))
            } else if let jsonArray = jsonData as? [[String:Any]] {
                completion(Result.Success(result: jsonArray))
            } else {
                completion(Result.Error(error: APIError.jsonSerializationFailed))
            }
            
            }.resume()
    }
    
    private  func configuration(forURL url: URL, httpMethod: String) -> (request: URLRequest, session: URLSession) {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let request = URLRequest(url: url)
        return (request, session)
    }
}
