//
//  ContentView.swift
//  GuessFlags
//
//  Created by eren on 26.08.2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var countries : [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctCountry : Int = Int.random(in: 0...2)
    @State private var showingAlert : Bool = false
    @State private var alertTitle : String = ""
    
    @State private var score : Int = 0
    @State private var oldCountry : String = ""
    
    private func FlagTapped(_ number: Int ){
        if number == correctCountry{
            score += 1
            AskQuestion()
        }
        else{
            oldCountry = countries[number]
            showingAlert = true
        }
    }
    
    private func AskQuestion(){
        countries.shuffle()
        correctCountry = Int.random(in: 0...2)
    }
        
    
    
    var body: some View {
        ZStack{
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Welcome to GuessFlags 🤠").font(.title.weight(.bold)).foregroundStyle(.black)
                VStack(spacing:15){
                    VStack(){
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctCountry]).foregroundStyle(.secondary).font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button(){
                            FlagTapped(number)
                        }label: {
                            Image(countries[number]).clipShape(.capsule).shadow(radius: 5)
                        }
                        .alert(alertTitle, isPresented: $showingAlert ){
                            Button("Continue", action: AskQuestion)
                        } message: {
                            Text("That is \(oldCountry)")
                            Text("Your score is : \(score)")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Your Score: \(score)").font(.title2.weight(.semibold)).foregroundStyle(.primary)
            }
            .padding()
            
        }
    }
        
        
}

#Preview {
    ContentView()
}
