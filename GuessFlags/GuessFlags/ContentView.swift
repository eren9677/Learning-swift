//
//  ContentView.swift
//  GuessFlags
//
//  Created by eren on 26.08.2024.
//

import SwiftUI


struct ContentView: View {
    
    private var countries : [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "Ukraine", "US"]
    private var corectCountry : Int = Int.random(in: 0...2)
    
    
    
    var body: some View {
        ZStack{
            Color(red :1, green: 0.5, blue: 0 ).ignoresSafeArea()
            VStack(spacing:30){
                VStack(){
                    Text("Select the flag of").foregroundStyle(.white)
                    Text(countries[corectCountry]).foregroundStyle(.white)
                }
                
                ForEach(0..<3){ number in
                    Button(){
                        
                    }label: {
                        Image(countries[number])
                    }
                }
            }
        }
    }
        
        
}

#Preview {
    ContentView()
}
