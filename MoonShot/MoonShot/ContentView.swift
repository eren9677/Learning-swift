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
                                    .padding(.vertical)
                                
                                VStack {
                                    Text(mission.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(String(mission.formattedLaunchDate))
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.7))
                                    
                                }
                                .padding(.vertical)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .background(.lightBackground)
                            }
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }
                    
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
