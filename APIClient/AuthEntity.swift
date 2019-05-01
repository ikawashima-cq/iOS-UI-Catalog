//
//  AuthEntity.swift
//  APIClient
//
//  Created by Iichiro Kawashima on 2019/05/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation

struct AuthEntity: Decodable {

    let status: Int
    let result: Result

    struct Result: Decodable {
        let id: Int
        let email: String
        let token: String
    }
}

// MARK: - ResultType
enum APIResult {
    case success(Decodable)
    case failure(Error)
}

// MARK: - ErrorResponse
struct ErrorResponse: Error, CustomStringConvertible {
    public let description: String = "-- Decode Error --"
    var dataContents: String?
}

// MARK: - JSONDecoder Extension
extension JSONDecoder {

    convenience init(type: JSONDecoder.KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = type
    }
}
