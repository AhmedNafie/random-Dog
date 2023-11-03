//
//  DogStruct.swift
//  Random Dog With API 23
//
//  Created by Ahmed Nafie on 20/07/2023.
//

import Foundation

struct DogImage: Codable {
    let message: String
    let status: String
    var url: URL {
        return URL(string:message)!
    }
}
