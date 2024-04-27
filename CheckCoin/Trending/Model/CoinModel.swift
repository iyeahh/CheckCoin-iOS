//
//  CoinModel.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI

struct CoinModel: Hashable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let price: Double
    let priceChange: Double

    var url: URL? {
        return URL(string: image)
    }

    var priceString: String {
        let digit: Double = pow(10, 4)
        return "$" + String(round(price * digit) / digit)
    }

    var priceChangeString: String {
        let digit: Double = pow(10, 2)
        let value = String(round(priceChange * digit) / digit)
        return priceChange > 0 ? "+" + value + "%" : "-" + value + "%"
    }

    var colorPriceChange: Color {
        priceChange > 0 ? .red : .blue
    }
}
