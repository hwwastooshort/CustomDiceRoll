//
//  ContentView.swift
//  CustomDiceRoll
//
//  Created by Harvey Wirth on 02.01.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "dice")
                        .foregroundColor(.white)
                        .font(.title)
                    Text("CustomDiceRoller")
                        .foregroundStyle(.white)
                        .font(.title)
                }
                .padding(.top, 50) // Abstand von oben
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
