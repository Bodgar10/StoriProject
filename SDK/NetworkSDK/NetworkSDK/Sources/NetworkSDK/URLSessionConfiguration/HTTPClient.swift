//
//  File.swift
//  NetworkSDK
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import Foundation

public protocol HTTPClient {
    func get<T: Decodable>(from url: URL, httpMethod: HTTPMethod, headers: [String: String]?, body: Data?) async throws -> T
}
