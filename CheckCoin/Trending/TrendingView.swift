//
//  TrendingView.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI

struct TrendingView: View {
    var body: some View {
        NavigationView {
                VStack {
                    ScrollView {
                        myfavoriteHStack()
                        topCoinScrollView(title: "Top 15 Coin")
                        topCoinScrollView(title: "Top 7 NFT")
                        Spacer()
                    }
                    bottomBar()
                }
                .navigationTitle("Check Coin")
        }
    }


    private func topCoinScrollView(title: String) -> some View {
        VStack {
            sectionTitle(title)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(0..<5) { _ in
                        topCoinVStack()
                    }
                }
                .padding(.leading, 20)
                .padding(.top, -10)
            }
        }
    }

    private func topCoinVStack() -> some View {
        VStack(spacing: -10) {
            topCoin()
            grayBar()
            topCoin()
            grayBar()
            topCoin()
        }
    }

    private func grayBar() -> some View {
        Rectangle()
            .frame(width: 300, height: 1)
            .foregroundColor(.gray.opacity(0.1))
    }

    private func topCoin() -> some View {
        HStack {
            Text("1")
                .font(.title3)
                .bold()
            coinName()
            coinDollar()
        }
        .frame(width: 300, height: 100)
    }

    private func coinDollar() -> some View {
        VStack {
            Text("$0.4175")
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text("+21.18%")
                .font(.caption)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    private func myfavoriteHStack() -> some View {
        VStack {
            sectionTitle("My Favorite")
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(0..<5) { _ in
                        myfavorite()
                    }
                }
                .padding(.leading, 20)
            }
        }
    }

    private func myfavorite() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.gray.opacity(0.1))
                .frame(width: 200, height: 150)

                .overlay {
                    VStack {
                        coinName()
                        price()
                    }
                }
        }
    }

    private func price() -> some View {
        VStack {
            Text("₩69,234,245")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("+0.64%")
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }

    private func coinName() -> some View {
        HStack {
            Image(systemName: "star")
                .frame(width: 30, height: 30)
            VStack {
                Text("Bitcoin")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("BTC")
                    .font(.caption)
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

#Preview {
    TrendingView()
}
