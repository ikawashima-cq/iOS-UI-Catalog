//
//  BaseRequest.swift
//  APIClient
//
//  Created by Iichiro Kawashima on 2019/05/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseRequest {
    associatedtype ResponseType

    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
}

extension BaseRequest {

    var baseURL: URL {
        return URL(string: "http://54.250.239.8")!
    }
}

protocol BaseRequestProtcol: BaseRequest, URLRequestConvertible {
    var parameters: Parameters? { get }
    var encoding: URLEncoding { get }
}

extension BaseRequestProtcol {
    var encoding: URLEncoding {
        // parameter の変換の仕方を設定
        // defaultの場合、get→quertString、post→httpBodyとよしなに行ってくれる
        return URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        // requestごとの　pathを設定
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))

        // requestごとの　methodを設定(get/post/delete etc...)
        urlRequest.httpMethod = method.rawValue

        // timeout時間を設定
        urlRequest.timeoutInterval = TimeInterval(5)

        // requestごとの　parameterを設定
        if let params = parameters {
            urlRequest = try encoding.encode(urlRequest, with: params)
        }

        return urlRequest
    }
}
