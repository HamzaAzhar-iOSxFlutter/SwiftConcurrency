//
//  Constants.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import Foundation

enum TypeOfRequest: String {
    case get = "get"
    case post = "post"
}

struct AppConstants {
    static let userURL = "https://jsonplaceholder.typicode.com/users"
}
