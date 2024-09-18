//
//  ContentView.swift
//  MoonShot
//
//  Created by eren on 17.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    var missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        Text("There are this many astronauts: ")
        Text(String(astronauts.count))
        Text("There are this many missions : ")
        Text(String(missions.count))
    }
}

#Preview {
    ContentView()
}
