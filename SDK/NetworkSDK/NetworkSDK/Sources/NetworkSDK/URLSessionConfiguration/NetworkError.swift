//
//  File.swift
//  NetworkSDK
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
}

public enum HTTPMethod: String {
    case GET, POST
}
