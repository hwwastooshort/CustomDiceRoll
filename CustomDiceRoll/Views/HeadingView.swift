//
//  HeadingView.swift
//  CustomDiceRoll
//
//  Created by Harvey Wirth on 05.01.25.
//

import SwiftUI

struct HeadingView: View {
    var headingText: String
    var body: some View {
        Text(headingText)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }
}

