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
    @State private var dragAmount2 : CGSize = CGSize.zero
    
    @State private var enabled : Bool = false
    let str : Array = Array("Hello, SwiftUI !")
    
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
        Spacer()
        
        VStack{
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
        
        Spacer()
        
        HStack{
            ZStack{
                HStack {
                    ForEach(0..<str.count, id: \.self){ num in
                        Text(String(str[num]))
                            .padding(2)
                            .font(.title)
                            .background(enabled ? .blue : .red)
                            .clipShape(.capsule)
                            .offset(dragAmount2)
                            .animation(.linear.delay(Double(num) / 20), value: dragAmount2)
                        
                    }
                }
                .background(withAnimation(.snappy){
                    enabled ? .blue : .red
                })
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding()
            }
            
        }
        .gesture(
            DragGesture()
                .onChanged{ dragAmount2 = $0.translation}
                .onEnded{ _ in
                    dragAmount2 = .zero
                    enabled.toggle()
                }
            
        )

        
    }
        
        
        
    }

#Preview {
    ContentView()
}
