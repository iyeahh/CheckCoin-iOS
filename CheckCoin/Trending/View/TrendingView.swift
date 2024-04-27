//
//  TrendingView.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI
import Kingfisher

struct TrendingView: View {
    @State var coinList: [CoinModel] = []
    @State var nftList: [NFTModel] = []

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    myfavoriteHStack(image: URL(string: "https://coin-images.coingecko.com/coins/images/39760/standard/photo_2024-08-16_17.29.08.png?1723903486"), name: "안녕", symbol: "안녕", price: "39393", priceChange: "393")
                    topCoinScrollView(title: "Top 15 Coin", coin: coinList)
                    topNFTScrollView(title: "Top 7 NFT", nft: nftList)
                    Spacer()
                    bottomBar()
                }
            }
            .navigationTitle("Check Coin")
        }
        .task {
            await loadCoinData()
        }
    }

    // 데이터를 가져오는 작업을 함수로 분리
    private func loadCoinData() async {
        APIManager.shared.fetchTrending { value in
            // 코인 데이터를 처리
            if let coin = value.coins,
               let nft = value.nfts {
                processCoinData(value: coin)
                processNFTData(value: nft)
            }
        }
    }

    private func processCoinData(value: [CoinItem]) {
        coinList = value.map { coin in
            CoinModel(
                id: coin.item?.id ?? "아이디 없음",
                name: coin.item?.name ?? "이름 없음",
                symbol: coin.item?.symbol ?? "심볼 없음",
                image: coin.item?.small ?? "이미지 없음",
                price: coin.item?.data?.price ?? 0,
                priceChange: Double(coin.item?.data?.price_change_percentage_24h?.krw ?? 0)
            )
        }
    }

    private func processNFTData(value: [Nft]) {
        nftList = value.map { nft in
            NFTModel(
                name: nft.name ?? "이름 없음",
                symbol: nft.symbol ?? "심볼 없음",
                image: nft.thumb ?? "이미지 없음",
                price: nft.data?.floor_price ?? "0",
                priceChange: Double(nft.data?.floor_price_in_usd_24h_percentage_change ?? "0.0") ?? 0.0
            )
        }
    }

    private func topNFTScrollView(title: String, nft: [NFTModel]) -> some View {
        VStack {
            sectionTitle(title)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    if !nftList.isEmpty {
                        ForEach(0..<2) { i in
                            let startIndex = i * 3
                            let nftItems = [nft[startIndex], nft[startIndex + 1], nft[startIndex + 2]]
                            topNFTVStack(nfts: nftItems)
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.top, -10)
            }
        }
    }

    private func topCoinScrollView(title: String, coin: [CoinModel]) -> some View {
        VStack {
            sectionTitle(title)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    if !coinList.isEmpty {
                        ForEach(0..<5) { i in
                            let startIndex = i * 3
                            let coinItems = [coin[startIndex], coin[startIndex + 1], coin[startIndex + 2]]
                            topCoinVStack(coins: coinItems)
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.top, -10)
            }
        }
    }

    private func topNFTVStack(nfts: [NFTModel]) -> some View {
        VStack(spacing: -15) {
            let firstNFT = nfts[0]
            let secondNFT = nfts[1]
            let thirdNFT = nfts[2]

            topCoin(image: firstNFT.url, name: firstNFT.name, symbol: firstNFT.symbol, price: firstNFT.priceString, priceChange: firstNFT.priceChangeString)
            grayBar()
            topCoin(image: secondNFT.url, name: secondNFT.name, symbol: secondNFT.symbol, price: secondNFT.priceString, priceChange: secondNFT.priceChangeString)
            grayBar()
            topCoin(image: thirdNFT.url, name: thirdNFT.name, symbol: thirdNFT.symbol, price: thirdNFT.priceString, priceChange: thirdNFT.priceChangeString)
        }
    }

    private func topCoinVStack(coins: [CoinModel]) -> some View {

        VStack(spacing: -15) {
            let firstCoin = coins[0]
            let secondCoin = coins[1]
            let thirdCoin = coins[2]

            topCoin(image: firstCoin.url, name: firstCoin.name, symbol: firstCoin.symbol, price: firstCoin.priceString, priceChange: firstCoin.priceChangeString)
            grayBar()
            topCoin(image: secondCoin.url, name: secondCoin.name, symbol: secondCoin.symbol, price: secondCoin.priceString, priceChange: secondCoin.priceChangeString)
            grayBar()
            topCoin(image: thirdCoin.url, name: thirdCoin.name, symbol: thirdCoin.symbol, price: thirdCoin.priceString, priceChange: thirdCoin.priceChangeString)
        }
    }

    private func grayBar() -> some View {
        Rectangle()
            .frame(width: 300, height: 1)
            .foregroundColor(.gray.opacity(0.1))
    }

    private func topCoin(image: URL?, name: String, symbol: String, price: String, priceChange: String) -> some View {
        HStack {
            Text("1")
                .font(.title3)
                .bold()
            coinName(image: image, name: name, symbol: symbol)
                .frame(width: 200)
            coinDollar(price: price, priceChange: priceChange)
        }
        .frame(width: 300, height: 100)
    }

    private func coinDollar(price: String, priceChange: String) -> some View {
        VStack {
            Text(price)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 14))
                .bold()
            Text(priceChange)
                .font(.caption)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    private func myfavoriteHStack(image: URL?, name: String, symbol: String, price: String, priceChange: String) -> some View {
        VStack {
            sectionTitle("My Favorite")
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(0..<5) { _ in
                        myfavorite(image: image, name: name, symbol: symbol, price: price, priceChange: priceChange)
                    }
                }
                .padding(.leading, 20)
            }
        }
    }

    private func myfavorite(image: URL?, name: String, symbol: String, price: String, priceChange: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.gray.opacity(0.1))
                .frame(width: 200, height: 150)

                .overlay {
                    VStack {
                        coinName(image: image, name: name, symbol: symbol)
                        priceVStack(price, change: priceChange)
                    }
                }
        }
    }

    private func priceVStack(_ price: String, change: String) -> some View {
        VStack {
            Text(price)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(change)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }

    private func coinName(image: URL?, name: String, symbol: String) -> some View {
        HStack {
            KFImage(image)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            VStack {
                Text(name)
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

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .bold()
            .padding(.leading, 20)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func bottomBar() -> some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.gray.opacity(0.1))
            .padding(.bottom, 10)
    }

}
