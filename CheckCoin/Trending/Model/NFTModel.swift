//
//  NFTModel.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI

struct NFTModel: Hashable {
    let name: String
    let symbol: String
    let image: String
    let price: String
    let priceChange: Double

    var url: URL? {
        return URL(string: image)
    }

    var priceString: String {
        let array = price.split(separator: " ")
        let doubleValue = String(array[0])
        let doubleString = String(format: "%.2f", Double(doubleValue) ?? 0.0)
        return doubleString + " " + array[1]
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
