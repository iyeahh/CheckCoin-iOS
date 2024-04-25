//
//  TrendingView.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/6/24.
//

import SwiftUI

struct TrendingView: View {
    var body: some View {
        VStack {
            Text("안녕")
            Spacer()
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    TrendingView()
}
