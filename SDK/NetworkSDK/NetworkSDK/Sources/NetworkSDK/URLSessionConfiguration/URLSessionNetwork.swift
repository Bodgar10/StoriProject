//
//  File.swift
//  NetworkSDK
//
//  Created by Bodgar Espinosa Miranda on 17/12/24.
//

import Foundation

public final class URLSessionNetwork: HTTPClient {
    
    private let urlSession: URLSession
        
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func get<T: Decodable>(
        from url: URL,
        httpMethod: HTTPMethod = .GET,
        headers: [String: String]? = nil,
        body: Data? = nil
    ) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }
}
