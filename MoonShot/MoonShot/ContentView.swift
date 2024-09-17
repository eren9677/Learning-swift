//
//  ContentView.swift
//  MoonShot
//
//  Created by eren on 17.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    var astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text("There are this many astronauts: ")
        Text(String(astronauts.count))
    }
}

#Preview {
    ContentView()
}
