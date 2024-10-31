//
//  ViewModel.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import Foundation
import Combine

protocol UserFetching {
    func usersFetched()
    func failedToGetResponse(error: String)
}

class ViewModel {
    
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var userModelPublished: [UserModel] = []
    private let repository: CombineRepository
    var delegate: UserFetching?
    
    init(repository: CombineRepository) {
        self.repository = repository
    }
    
    func fetchUsers() {
        self.repository.fetchUsers()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("success!!")
                case .failure(let error):
                    self?.delegate?.failedToGetResponse(error: error.localizedDescription)
                }
            } receiveValue: { response in
                self.userModelPublished = response
                self.delegate?.usersFetched()
            }.store(in: &cancellables)

    }
}
