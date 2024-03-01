//
//  FavoriteView.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI

struct FavoriteView: View {

    @State var coinList: [CoinTable] = []

    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .task {
                    coinList = RealmManager.shared.fetchList()
                }
                .navigationTitle("Favorite Coin")
        }
    }
}

#Preview {
    FavoriteView()
}
