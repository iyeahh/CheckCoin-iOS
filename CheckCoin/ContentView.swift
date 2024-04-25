//
//  ContentView.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(.purple)
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            FavoriteView()
                .tabItem {
                    Image(systemName: "folder")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}
