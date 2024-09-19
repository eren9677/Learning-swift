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
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns:columns){
                    ForEach(missions) { mission in
                        NavigationLink{
                            Text("Detail View for \(mission.name)")
                        }label: {
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                
                                VStack {
                                    Text(mission.name)
                                        .font(.headline)
                                    
                                    
                                    Text(String(mission.formattedLaunchDate))
                                        .font(.caption)
                                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                }
            }
            .navigationTitle("MoonShot")
        }
    }
}

#Preview {
    ContentView()
}
