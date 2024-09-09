//
//  ContentView.swift
//  Animations
//
//  Created by eren on 9.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount : Double = 1.0
    var body: some View {
        
        Button("Tap me"){
        }
        .padding(50)
        .background(.red)
        .clipShape(.circle)
        .foregroundColor(.white)
        .overlay(
            Circle()
                .stroke(.red)
                       .scaleEffect(animationAmount)
                       .opacity(2 - animationAmount)
                       .animation(
                           .easeInOut(duration: 1)
                               .repeatForever(autoreverses: false),
                           value: animationAmount
                       )
        )
        .onAppear{
            animationAmount = 2
        }
    }
}

#Preview {
    ContentView()
}
