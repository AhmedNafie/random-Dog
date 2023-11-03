//
//  DogListResponse.swift
//  Random Dog With API 23
//
//  Created by Ahmed Nafie on 24/07/2023.
//

import Foundation

struct BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
