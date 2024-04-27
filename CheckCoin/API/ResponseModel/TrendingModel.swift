//
//  TrendingModel.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import Foundation

struct TrendingModel: Decodable {
    let coins: [CoinItem]?
    let nfts: [Nft]?
}

struct CoinItem: Decodable {
    let item: Coin?
}

struct Coin: Decodable {
    let id: String?
    let name: String?
    let symbol: String?
    let small: String?
    let data: CoinData?
}

struct CoinData: Decodable {
    let price: Double?
    let price_change_percentage_24h: PriceChanged?
}

struct PriceChanged: Decodable {
    let krw: Double?
}

struct Nft: Decodable {
    let name: String?
    let symbol: String?
    let thumb: String?
    let data: NftData?
}

struct NftData: Decodable {
    let floor_price: String?
    let floor_price_in_usd_24h_percentage_change: String?
}
