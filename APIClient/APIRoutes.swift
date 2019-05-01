//
//  APIRoutes.swift
//  APIClient
//
//  Created by Iichiro Kawashima on 2019/05/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Alamofire

enum APIRoutes {
    case signIn
    case signUp
    case logout

    public var path: String {
        switch self {
        case .signIn:
            return "/login"
        case .signUp:
            return "/sign_up"
        case .logout:
            return "/logout"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .logout:
            return .delete
        }
    }
}
