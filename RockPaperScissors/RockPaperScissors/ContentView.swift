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
            .clipShape(.capsule)
            .shadow(radius: 5)
    
            
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
                    
                    ForEach(options, id: \.self){ option in
                        Button(){
                            
                        }label: {
                            OptionImage(file : option)
                            
                        }
                    }
                
                }.blockIt()
                
            }
        }
    }
}

#Preview {
    ContentView()
}
