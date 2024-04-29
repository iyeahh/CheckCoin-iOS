//
//  SearchView.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @State private var searchText = ""
    @State private var coinList: [SearchCoinModel] = []

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($coinList, id: \.id) { $item in
                    CellView(item: $item, searchText: searchText)
                }
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    callRequest()
                }
                .navigationTitle("Search")
            }
        }
    }

    private func callRequest() {
        APIManager.shared.fetchData(url: APIKey.searchURL + searchText) { (value: SearchModel) -> Void in
            let array = value.coins?.sorted(by: {
                if let first = $0.market_cap_rank,
                   let second = $1.market_cap_rank {
                    return first < second
                } else {
                    return false
                }
            })
            coinList = array?.map({ coin in
                SearchCoinModel(
                    coinId: coin.id ?? "아이디없음",
                    name: coin.name ?? "이름없음",
                    symbol: coin.symbol ?? "심볼없음",
                    thumb: coin.thumb ?? "이미지없음"
                )
            }) ?? []

            var index = 0
            coinList.forEach { coin in
                if RealmManager.shared.checkIsLike(item: coin) {
                    coinList[index].isLike = true
                } else {
                    coinList[index].isLike = false
                }
                index += 1
            }
        }
    }


    private func coinName(image: URL?, name: String, symbol: String) -> some View {
        HStack {
            KFImage(image)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            VStack {
                TextWithColoredSubstring(originalText: name, coloredSubstring: searchText)
                    .font(.system(size: 14))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                Text(symbol)
                    .font(.caption2)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
}

struct CoinNameView: View {
    let coinId: String
    let image: URL?
    let name: String
    let symbol: String
    var searchText: String
    var body: some View {
        HStack {
            KFImage(image)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            VStack {
                TextWithColoredSubstring(originalText: name, coloredSubstring: searchText)
                    .font(.system(size: 14))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                Text(symbol)
                    .font(.caption2)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
}

struct CellView: View {
    @Binding var item: SearchCoinModel
    var searchText: String

    var body: some View {
        HStack {
            CoinNameView(coinId: item.coinId, image: item.url, name: item.name, symbol: item.symbol, searchText: searchText)
            Button(action: {
                if item.isLike {
                    RealmManager.shared.removeIsLike(item.name)
                } else {
                    RealmManager.shared.addIsLike(coinId: item.coinId, image: item.thumb, name: item.name, symbol: item.symbol)
                }
                item.isLike.toggle()
            }, label: {
                Image(systemName: item.isLike ? "star.fill" : "star")
                    .padding()
            })
        }
    }
}
