//
//  HttpClient.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badNetworkRequest
    case badUrl
}


protocol CombineHttpRequesting {
    func fetch<T: Decodable>(request: URLRequest, response: T.Type) -> AnyPublisher<T, Error>
}

class CombineHttpClient: CombineHttpRequesting {
    func fetch<T>(request: URLRequest, response: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: response, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError { error in
                // Convert the error to a NetworkError if possible, otherwise return a bad network request error.
                return error as? NetworkError ?? NetworkError.badNetworkRequest
            }
            .eraseToAnyPublisher()
        
    }
}
