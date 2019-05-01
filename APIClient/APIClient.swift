//
//  APIClient.swift
//  APIClient
//
//  Created by Iichiro Kawashima on 2019/05/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/*
# アクセスコントロールの名前: アクセスコントロールの概要
- open: Framework外から参照およびoverrideが可
- public: Framework外から参照可、overrideは不可
- internal(= 無記入): 同一Framework内からの参照のみ可
- fileprivate: 同一ファイル内からの参照のみ可
- private: 外部からの参照は不可
*/

struct APIClient {

    private static let successRange = 200..<400
    private static let contentType = ["application/json"]

    public static func call<T, V>(_ request: T, _ disposeBag: DisposeBag, onSuccess: @escaping (V) -> Void, onError: @escaping (Error) -> Void)
        where T: BaseRequestProtcol, V: Codable, T.ResponseType == V {

            _ = observe(request)
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { onSuccess($0) },
                           onError: { onError($0) })
                .disposed(by: disposeBag)
    }

    // RxSwiftを導入している部分。成功/失敗いずれかしか返らないSingleにしてある。
    private static func observe<T, V>(_ request: T) -> Single<V>
        where T: BaseRequestProtcol, V: Codable, T.ResponseType == V {

            return Single<V>.create { observer in
                let calling = callForData(request) { response in
                    switch response {
                    //※ 既にsuccessしているので「as! V」で強制キャストしている（できる）
                    case .success(let result): observer(.success(result as! V))
                    case .failure(let error): observer(.error(error))
                    }
                }

                return Disposables.create() { calling.cancel() }
            }
    }

    // Alamofire呼び出し部分
    private static func callForData<T, V>(_ request: T, completion: @escaping (APIResult) -> Void) -> DataRequest
        where T: BaseRequestProtcol, V: Codable, T.ResponseType == V {

            return customAlamofire(request).responseJSON { response in
                switch response.result {
                case .success: completion(decodeData(request, response.data))
                case .failure(let error): completion(.failure(error))
                }
            }
    }

    // Alamofireのメソッドのみ切り出した部分
    private static func customAlamofire<T>(_ request: T) -> DataRequest
        where T: BaseRequestProtcol {

            return Alamofire
                .request(request)
                .validate(statusCode: successRange)
                .validate(contentType: contentType)
    }

    // JSONをDecoderしている部分
    private static func decodeData<T, V>(_ request: T, _ data: Data?) -> APIResult
        where T: BaseRequest, V: Codable, T.ResponseType == V {

            if let d = data, let result = try? JSONDecoder(type: .convertFromSnakeCase).decode(V.self, from: d) {
                return .success(result)

            } else { // Decodeエラー時はErrorResponseを返すようにしている。またdata内容も付与しておく。
                return .failure(ErrorResponse(dataContents: String(data: data ?? Data(), encoding: .utf8)))

            }
    }

}
