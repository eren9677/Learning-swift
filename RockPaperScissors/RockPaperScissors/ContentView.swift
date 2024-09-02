//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by eren on 28.08.2024.
//

import SwiftUI

struct OptionImage: View {
    
    var file : String
    
    var body: some View {
        Image(file)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: 100)
            .clipShape(.capsule)
            .shadow(radius: 5)
            .padding()
    
            
    }
}


struct Welcome : View {
    
    var text : String
    
    var body: some View {
        Text(text).font(.largeTitle).fontWeight(.bold).foregroundStyle(.primary)
            .padding()
    }
}


struct Block : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.vertical)
            .background(.thickMaterial)
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View{
    func blockIt() -> some View {
        modifier(Block())
    }
}



struct ContentView: View {
    
    private let options : [String] = ["Rock","Paper","Scissors"]
    @State private var selectedOption : Int = Int.random(in: 0...2)
    
    private let ends : [String] = ["Win","Lose"]
    @State private var selectedEnd : Int = Int.random(in: 0...1)
    
    
    private let checkMatrix : [Int : [Int : Int]] = [
        //0 is for lose and 1 is for win
        0 : [0: 1, 1: 2],   //each row is the rock paper scissors
        1 : [0: 2, 1: 0],
        2 : [0: 0, 1: 1],
    ]
    
    @State private var score : Int = 0
    @State private var turns : Int = 0
    
    @State private var turnsUp : Bool = false
    
    private func checkCorrect(_ option : Int) {
        
        if turns == 10 {
            turnsUp.toggle()
        }
        else{
            if let correctmove = checkMatrix[selectedOption]?[selectedEnd] {
                if correctmove == option {
                    score += 1
                    turns += 1
                    AskTurn()
                    
                }
                
                else{
                    turns += 1
                    if score != 0 {
                        score -= 1
                    }
                    showAlert.toggle()
                }
            }
            else {
                print("unable matrix move")
            }
        }
    }
    
    
    private func AskTurn(){
        selectedOption = Int.random(in: 0...2)
        selectedEnd = Int.random(in: 0...1)
    }
    
    private func RestartGame(){
        score = 0
        turns = 0
        AskTurn()
    }
    
    @State private var showAlert : Bool = false
    
    

    
    
    var body: some View {
        ZStack{
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red ], center: .center).ignoresSafeArea()
            VStack{
                VStack{
                    Welcome(text: "Welcome!")
                }
                
                VStack{
                    
                    HStack(){
                        Text("Opponent Selects:")
                        Text("\(options[selectedOption])").font(.title3).bold()
                    }
                    
                    HStack{
                        Text("Select a move to ")
                        Text("\(ends[selectedEnd])").font(.title2).bold().foregroundStyle(
                            
                            ends[selectedEnd] == "Win" ? .green : .red
                        )
                    }
                    
                }.blockIt()
                
                HStack{
                    
                    ForEach(0..<3){ option in
                        Button(){
                            checkCorrect(option)
                            
                        }label: {
                            OptionImage(file : options[option])
                            
                        }.alert("Wrong Move", isPresented: $showAlert) {
                            
                        }
                    }
                
                }.blockIt()
                
                HStack{
                    Text("Your Score is : \(score)")
                        .alert("No Turns Left", isPresented: $turnsUp ){
                        Button("Restart", action : RestartGame )
                    }message: {
                        Text("your score is : \(score)")
                    }

                }.blockIt()
                
            }.padding()
        }
    }
}

#Preview {
    ContentView()
}
