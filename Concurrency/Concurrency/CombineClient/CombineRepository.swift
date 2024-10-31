//
//  CombineRepository.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import Foundation
import Combine

class CombineRepository {
    
    let combineHttpRequesting: CombineHttpRequesting
    
    init(combineHttpRequesting: CombineHttpRequesting) {
        self.combineHttpRequesting = combineHttpRequesting
    }
    
    func fetchUsers() -> AnyPublisher<[UserModel], Error> {
        var urlRequest = URLRequest(url:  URL(string: AppConstants.userURL)!)
        urlRequest.httpMethod = TypeOfRequest.get.rawValue
        
        return self.combineHttpRequesting.fetch(request: urlRequest, response: [UserModel].self)
    }
}
