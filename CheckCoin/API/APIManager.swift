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

    func fetchTrending(completion: @escaping (TrendingModel) -> Void) {
        AF.request(APIKey.trendingURL)
            .responseDecodable(of: TrendingModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure:
                    print("코인 정보 가져오기 실패")
                }
            }
    }
}
