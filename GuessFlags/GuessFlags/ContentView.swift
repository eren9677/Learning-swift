//
//  ContentView.swift
//  GuessFlags
//
//  Created by eren on 26.08.2024.
//

import SwiftUI

struct FlagImage2: View {
    
    var file : String
    
    var body: some View {
        Image(file)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.capsule)
            .frame(width: 150, height:100)
            .scaledToFit()
            .shadow(radius: 5)
            
    }
}


// i will create a custom view modifier for making the text bluee

struct BlueImage : ViewModifier {
    func body(content: Content) -> some View {
        content.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundStyle(.blue)
    }
}

extension View {
    func blueTitle() -> some View{
        modifier(BlueImage())
    }
}




struct ContentView: View {
    
    @State private var countries : [String] = ["Afghanistan", "Albania", "Algeria", "Argentina", "Austria", "Azerbaijan", "Belarus", "Bhutan", "Brazil", "Bulgaria", "Canada", "China","Estonia","France","Germany","Greece","India","Indonesia","Ireland","Israel","Italy","Jamaica","Japan","Kazakhstan","Kyrgzstan","Lebanon","Monaco","Montenegro","Morocco","Netherlands","Nigeria","North Korea","Norway","Poland","Spain","Sweden","Switzerland","Thailand","Tunisia","Turkey","Uganda","UK","Ukraine","US","Vietnam"].shuffled()
    
    @State private var correctCountry : Int = Int.random(in: 0...2)
    @State private var showingAlert : Bool = false
    @State private var alertTitle : String = ""
    
    @State private var score : Int = 0
    @State private var oldCountry : String = ""
    private let totalTime : Int = 150
    @State private var elapsed : Int = 0
    
    @State private var timeUp : Bool = false
    
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
    private func StartTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.elapsed < self.totalTime {
                self.elapsed += 1
            } else {
                timer.invalidate()
                timeUp.toggle()
            }
        }
    }
    
    private func RestartGame(){
        score = 0
        elapsed = 0
        AskQuestion()
        StartTimer()
    }
        
    
    
    var body: some View {
        ZStack{
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Welcome to GuessFlags 🤠").font(.title.weight(.bold)).foregroundStyle(.black)
                
                Text("Time left : \(totalTime-elapsed) sec")
                    .onAppear {
                        StartTimer()
                    }
                    .alert("Time is up", isPresented: $timeUp ){
                        Button("Restart", action : RestartGame )
                    }message: {
                        Text("your score is : \(score)")
                    }
                
                VStack(spacing:15){
                    VStack(){
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctCountry]).foregroundStyle(.secondary).font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button(){
                            FlagTapped(number)
                        }label: {
                            FlagImage2(file : countries[number])
                        }
                        .alert(alertTitle, isPresented: $showingAlert ){
                            Button("Continue", action: AskQuestion)
                        } message: {
                            Text("That is \(oldCountry)")
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
