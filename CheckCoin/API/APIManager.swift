//
//  APIManager.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import Foundation
import Alamofire

final class APIManager {
    static let shared = APIManager()

    private init() { }

    func fetchData<T: Decodable>(url: String, completion: @escaping (T) -> Void) {
        AF.request(url)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print("코인 정보 가져오기 실패")
                    print(error)
                }
            }
    }
}
