//
//  DetailCoinModel.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/7/24.
//

import Foundation

struct DetailCoinModel: Decodable {
    let id: String?
    let name: String?
    let symbol: String?
    let image: String?
    let current_price: Int?
    let price_change_percentage_24h: Double?
    let low_24h: Int?
    let high_24h: Int?
    let ath: Int?
    let ath_date: String?
    let atl: Int?
    let atl_date: String?
    let last_updated: String?
}
