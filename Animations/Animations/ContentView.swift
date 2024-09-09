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
            animationAmount += 0.5
        }
        .padding(50)
        .background(.red)
        .clipShape(.circle)
        .foregroundColor(.white)
        .scaleEffect(animationAmount)
        .animation(.bouncy(), value: animationAmount)
    }
}

#Preview {
    ContentView()
}
