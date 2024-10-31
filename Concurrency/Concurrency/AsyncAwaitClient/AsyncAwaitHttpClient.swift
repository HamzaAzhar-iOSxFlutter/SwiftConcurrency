//
//  AsyncAwaitHttpClient.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import Foundation

enum ResponseError: Error {
    case badURL
    case badStatusCode
}

protocol AsyncHttpRequesting {
    func post<T: Decodable>(request: URLRequest, response: T.Type) async throws -> T
}

class AsyncAwaitHttpClient: AsyncHttpRequesting {
    func post<T>(request: URLRequest, response: T.Type) async throws -> T where T : Decodable {
        do {
            let (serverData, serverUrlResponse) = try await URLSession.shared.data(for: request)
            
            guard let httpStatusCode = (serverUrlResponse as? HTTPURLResponse)?.statusCode, (200...299).contains(httpStatusCode) else {
                throw ResponseError.badStatusCode
            }
            
            return try JSONDecoder().decode(response.self, from: serverData)
        } catch {
            throw error
        }
    }
    
}
