//
//  ContentView.swift
//  BetterRest
//
//  Created by eren on 3.09.2024.
//

import SwiftUI
import CoreML



struct Questions : ViewModifier {
    func body(content: Content) -> some View {
        content.font(.title2.weight(.bold)).foregroundStyle(.black)
    }
}

extension View {
    func question() -> some View {
        modifier(Questions())
    }
}

struct ContentView: View {
    
    @State private var wakeUp : Date = Date.now
    @State private var cupsOfCoffee : Int = 0
    @State private var sleepAmount : Double = 8
    
    @State private var alertTitle : String = ""
    @State private var alertMessage : String = ""
    @State private var showAlert : Bool = false
    
    func CalculateSleep(){
        do{
            let config = MLModelConfiguration()
            let model = try BetterRest(configuration : config)
            
            //more code to come by
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(cupsOfCoffee))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is: "
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }
        catch{
            alertTitle = "Error"
            alertMessage = "an error has occured"
        
        }
        
        showAlert = true
    }
    
    
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("When do you want to wake up?").question()
                
                DatePicker("please enter date" ,selection: $wakeUp, displayedComponents: .hourAndMinute
                ).labelsHidden()
                
                Text("How many cups of coffe you drink? ").question()
                
                Stepper("\(cupsOfCoffee)", value: $cupsOfCoffee, in: 0...12).padding()
                
                Text("Desired Amount of Sleep").question()
                
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25).padding()
                
            }
            
        .navigationTitle("BetterRest")
        .toolbar{
            Button("Done", action: CalculateSleep)
        }
        .alert(alertTitle, isPresented :$showAlert){
            Button("Ok"){}
        }message: {
            Text(alertMessage)
        }
        }
    }
}

#Preview {
    ContentView()
}
