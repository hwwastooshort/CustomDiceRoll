//
//  TextFieldView.swift
//  CustomDiceRoll
//
//  Created by Harvey Wirth on 05.01.25.
//

import SwiftUI

struct TextFieldView: View {
    
    @State var input = ""
    @Binding var rolledValue: Int
    @State var showErrorAllert = false
    @State var errorMessage = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "pencil")
                    .foregroundColor(.gray)
                    .font(.headline)
                
                ZStack(alignment: .leading) {
                    if input.isEmpty {
                        Text("2d6 + 3")
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $input)
                        .foregroundColor(.white)
                        .keyboardType(.asciiCapable)
                }
                Button {
                   print("Button has been pressed, entered expression: \(input)")
                    do {
                        rolledValue = try DiceNotationParser.parseAndEvaluate(input)
                        print("Calculated value: \(rolledValue)")
                    } catch {
                       errorMessage = "Invalid Input. Please check your dice roll syntax"
                       showErrorAllert = true
                    }
                } label: {
                    Image(systemName: "dice")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .padding(.horizontal)
        }
        .alert("Error", isPresented: $showErrorAllert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
