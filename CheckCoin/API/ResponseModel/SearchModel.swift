//
//  SearchModel.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/7/24.
//

import Foundation

struct SearchModel: Decodable {
    let coins: [SearchCoin]?
}

struct SearchCoin: Decodable, Hashable {
    let id: String?
    let name: String?
    let symbol: String?
    let thumb: String?
    let market_cap_rank: Int?
}
