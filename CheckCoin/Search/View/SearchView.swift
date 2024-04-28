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
                ForEach(coinList, id: \.id) { item in
                    cellHStack(image: item.url, name: item.name, symbol: item.symbol)
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
                    name: coin.name ?? "이름없음",
                    symbol: coin.symbol ?? "심볼없음",
                    thumb: coin.thumb ?? "이미지없음"
                )
            }) ?? []
        }
    }

    private func cellHStack(image: URL?, name: String, symbol: String) -> some View {
        HStack {
            coinName(image: image, name: name, symbol: symbol)
            Button(action: {}, label: {
                Image(systemName: "star")
                    .padding()
            })
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
