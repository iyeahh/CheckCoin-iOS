//
//  SearchCoinModel.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/7/24.
//

import Foundation

struct SearchCoinModel: Hashable {
    let id = UUID()
    let coinId: String
    let name: String
    let symbol: String
    let thumb: String
    var isLike = false

    var url: URL? {
        return URL(string: thumb)
    }
}
