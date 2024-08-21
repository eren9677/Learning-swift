//
//  ContentView.swift
//  WeSplit
//
//  Created by eren on 21.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var scale : Int = 0
    var body: some View {
        VStack {
            Button {
                scale += 1
                
            } label: {
                Label(
                    title: { Text("Hello World!").font(.title3) },
                    icon: { Image(systemName: "snowflake").imageScale(.large) }
                )
            }
            .symbolEffect(.bounce, value: scale)
            .scaledToFit()
            
            Text("Button is clicked for \(scale) times")
            
            
        }
    }
}

#Preview {
    ContentView()
}
