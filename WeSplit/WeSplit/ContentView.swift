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
    @State private var tipPercentage: Int = 15
    
    let tipPercentages: [Int] = [0, 15, 20, 25, 30]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Amount", value: $check, format: .currency(code: Locale.current.currency?.identifier ?? "YEN" ))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("WeSplit")
        }
    }
}

#Preview {
    ContentView()
}
