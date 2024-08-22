//
//  ContentView.swift
//  WeSplit
//
//  Created by eren on 21.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var check: Double = 0.0
    @State private var people: Int = 2 // Minimum amount of a split made is two.
    @State private var tipPercentage: Int = 10
    
    @FocusState private var focusedField: Field?
    
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    // Enum to track the focused field
    enum Field {
        case checkAmount
    }
    
    private var totalPerPerson: Double {
        return (check + (check * Double(tipPercentage) / 100)) / Double(people)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $check, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .checkAmount)
                    
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<11, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Payment per person is:") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .onTapGesture {
                // Dismiss the keyboard when tapping outside the TextField
                focusedField = nil
            }
        }
    }
}

#Preview {
    ContentView()
}
