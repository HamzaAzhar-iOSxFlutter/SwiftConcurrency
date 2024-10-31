//
//  AsyncAwaitRepository.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import Foundation

class AsyncAwaitRepository {
    let asyncHttpRequesting: AsyncHttpRequesting
    
    init(asyncHttpRequesting: AsyncHttpRequesting) {
        self.asyncHttpRequesting = asyncHttpRequesting
    }
    
    func fetchUsers() async throws -> [UserModel] {
        var urlRequest = URLRequest(url:  URL(string: AppConstants.userURL)!)
        urlRequest.httpMethod = "get"
        
        do {
            return try await asyncHttpRequesting.post(request: urlRequest, response: [UserModel].self)
        } catch {
            throw error
        }
    }
    
}
