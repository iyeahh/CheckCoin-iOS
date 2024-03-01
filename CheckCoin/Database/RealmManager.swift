//
//  RealmManager.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/7/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()

    private init() { }

    var coinList: Results<CoinTable>!

    let realm = try! Realm()

    func fetchList() -> [CoinTable] {
        coinList = realm.objects(CoinTable.self)
        return Array(coinList)
    }

    func addIsLike(coinId: String, image: String, name: String, symbol: String) {
        let data = CoinTable(coinId: coinId, image: image, name: name, symbol: symbol)

        try! realm.write({
            realm.add(data)
        })
    }

    func checkIsLike(item: SearchCoinModel) -> Bool {
        fetchList()

        let filteredList = coinList.filter { coin in
            coin.name == item.name
        }

        if !filteredList.isEmpty {
            return true
        }

        return false
    }

    func removeIsLike(_ name: String) {
        fetchList()

        let filteredList = coinList.filter { coin in
            coin.name == name
        }

        if !filteredList.isEmpty,
           let value = filteredList.first {
            try! realm.write({
                realm.delete(value)
            })
        }
    }
}
