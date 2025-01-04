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
                Heading()
                    .padding(.top)
                Spacer()
                
                HStack {
                    Spacer()
                    DiceRollButton {
                        print("Button has been pressed")
                    }
                    .padding()
                }
            }
        }
    }
}

struct DiceRollButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Color.white
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                VStack {
                    Image(systemName: "dice")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                    Text("Roll")
                        .font(.callout)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct Heading: View {
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(15)
                .frame(height: 100)
                .padding(.horizontal, 20)
            HStack {
                Image(systemName: "dice")
                    .foregroundColor(.black)
                    .font(.title)
                Text("CustomDiceRoller")
                    .foregroundStyle(.black)
                    .font(.title)
            }
        }
    }
}


#Preview {
    ContentView()
}
