//
//  ContentView.swift
//  CustomDiceRoll
//
//  Created by Harvey Wirth on 02.01.25.
//

import SwiftUI

struct ContentView: View {
    @State private var result = 0
    var body: some View {
        ZStack {
            BackGroundView()
            VStack {
                Spacer()
                HeadingView(headingText: "CustomDiceRoll")
                Spacer()
                ScoreView(roll: result)
                Spacer()
                TextFieldView(rolledValue: $result)
                Spacer()
            }
        }
    }
}


#Preview {
    ContentView()
}
