//
//  CoinTable.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/7/24.
//

import Foundation
import RealmSwift

class CoinTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var coinId: String
    @Persisted var image: String
    @Persisted var name: String
    @Persisted var symbol: String

    convenience init(coinId: String, image: String, name: String, symbol: String) {
        self.init()
        self.id = id
        self.coinId = coinId
        self.image = image
        self.name = name
        self.symbol = symbol
    }
}
