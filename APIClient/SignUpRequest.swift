//
//  SignUpRequest.swift
//  APIClient
//
//  Created by Iichiro Kawashima on 2019/05/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Alamofire

public struct SignUpRequest: BaseRequest {
    typealias ResponseType = AuthEntity

    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var method: HTTPMethod {
        return APIRoutes.signUp.method
    }

    var path: String {
        return APIRoutes.signUp.path
    }

    var parameters: Parameters {
        return  [
            "email": email,
            "password": password
        ]
    }
}
