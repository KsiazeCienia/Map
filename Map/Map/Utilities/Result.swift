//
//  Result.swift
//  Map
//
//  Created by Marcin on 16.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//
import Foundation

typealias ResultBlock<T> = (Result<T>) -> ()
typealias ArrayResultBlock<T> = (ArrayResult<T>) -> ()

enum Result<T> {
    case Error(error : APIError)
    case Success(result : T)
}

enum ArrayResult<T> {
    case Error(error : APIError)
    case Success(result : [T])
}

enum APIError: CustomStringConvertible {
    case unexpectedError
    case noData
    case wrongHTTPCode(code: Int )
    case jsonSerializationFailed
    
    var description: String {
        switch self {
        case .unexpectedError:
            return NSLocalizedString("Unexpected error", comment: "")
        case .noData:
            return NSLocalizedString("Lack of levles", comment: "")
        case .jsonSerializationFailed :
            return NSLocalizedString("Unexpected error", comment: "")
        case .wrongHTTPCode(code: let code):
            return NSLocalizedString("Code \(code)", comment: "")
        }
    }
}
