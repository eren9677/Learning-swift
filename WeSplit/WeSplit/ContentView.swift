//
//  ContentView.swift
//  WeSplit
//
//  Created by eren on 21.08.2024.
//

import SwiftUI


struct MainView : View {
    
    @State private var people: Int = 2
    @State private var tipPercentage: Int = 10
    @State private var tipAmount: Double = 0.0
    @State private var tipPercentages: [Int] = [5, 10, 15, 20]
    @State private var checkAmount: Double = 0.0
    
    private var checkPerPerson: Double {
        return (checkAmount + (checkAmount * Double(tipPercentage) / 100)) / Double(people)
    } // calculated property
    
    func calculateFinalAmount()-> Double{
        return (checkAmount + (checkAmount * Double(tipPercentage) / 100)) / Double(people)
    } //calculated function.
    
    @FocusState private var focused: Bool
    
    var body: some View {
        
        NavigationView{
            Form {
                
                Section {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($focused)
                    
                    Picker("Number of People", selection: $people){
                        ForEach(2..<11, id:\.self){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section ("Select the tip Percentage: ") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tipPercentage in
                            Text("\(tipPercentage)%")
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Payment per person is : ") {
                    Text(checkPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                    Text(calculateFinalAmount(), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if focused {
                    ToolbarItem(placement: .automatic) {
                        Button("Done") {
                            self.focused = false
                        }
                    }
                }
            }
        }
    }
    
}































struct ContentView: View {
    @State private var check: Double = 0.0
    @State private var people: Int = 2 // Minimum amount of a split made is two.
    @State private var tipPercentage: Int = 10
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    @FocusState private var amountIsFocused: Bool
    
    private var totalPerPerson : Double {
        return (check + (check * Double(tipPercentage) / 100)) / Double(people)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", value: $check, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $people) {
                        ForEach(2 ..< 11 ,id: \.self){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section("Payment per person is : "){
                    
                    Text(totalPerPerson ,format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundStyle(tipPercentage == 0 ? Color.red : Color.primary)
                    
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
