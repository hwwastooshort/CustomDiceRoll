//
//  ScoreView.swift
//  CustomDiceRoll
//
//  Created by Harvey Wirth on 05.01.25.
//

import SwiftUI

struct ScoreView: View {
    var roll: Int
    var body: some View {
        Text("\(roll)")
            .font(.title2)
            .foregroundStyle(.white)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

#Preview {
    ScoreView(roll: 12)
}
