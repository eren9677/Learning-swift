//
//  ContentView.swift
//  Animations
//
//  Created by eren on 9.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount : Double = 1.0
    
    @State private var dragAmount : CGSize = CGSize.zero
    
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
        .padding()
        
        
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 20))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged{ dragAmount = $0.translation}
                    .onEnded{ _ in dragAmount = .zero}
            )
            .animation(
                .spring(duration: 0.6, bounce: 0.6)
                .repeatForever(autoreverses: false),
                value: dragAmount
            )
    }
        
        
        
    }

#Preview {
    ContentView()
}
