//
//  ContentView.swift
//  GuessFlags
//
//  Created by eren on 26.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            Color(red:1, green:0.8, blue:0)
            VStack{
                ForEach(1..<4){_ in
                    HStack{
                        ForEach(1..<4) {_ in
                            
                            Image(systemName: "globe")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                    }
                    
                }
            }.background(.ultraThinMaterial)
            
            VStack{
                Spacer()
                Spacer()
                Button("Click to me"){
                    print("button was clicked")
                }
                    .buttonStyle(.bordered)
                Spacer()
            }
            

        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
