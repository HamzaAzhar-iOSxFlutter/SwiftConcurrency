//
//  ViewModel.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import Foundation

protocol UserFetching {
    func usersFetched()
}

class ViewModel {
    
    let repository: AsyncAwaitRepository
    var delegate: UserFetching?
    var userModel: [UserModel] = []
    
    init(repository: AsyncAwaitRepository) {
        self.repository = repository
    }
    
    func fetchUsers() async {
        do {
            self.userModel = try await self.repository.fetchUsers()
            self.delegate?.usersFetched()
        } catch {
            print(error)
        }
    }
}
