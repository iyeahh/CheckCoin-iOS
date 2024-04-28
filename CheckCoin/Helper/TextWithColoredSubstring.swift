//
//  TextWithColoredSubstring.swift
//  CheckCoin
//
//  Created by Bora Yang on 9/7/24.
//

import SwiftUI

struct TextWithColoredSubstring: View {
    var originalText: String
    var coloredSubstring: String

    var body: some View {
        if let coloredRange = originalText.range(of: coloredSubstring, options: .caseInsensitive) {
            let beforeRange = originalText[..<coloredRange.lowerBound]
            let coloredText = originalText[coloredRange]
            let afterRange = originalText[coloredRange.upperBound...]

            return Text(beforeRange)
                .foregroundColor(.black)
                + Text(coloredText)
                    .foregroundColor(.purple)
                + Text(afterRange)
                    .foregroundColor(.black)
        } else {
            return Text(originalText)
                .foregroundColor(.black)
        }
    }
}
