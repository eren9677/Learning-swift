//
//  ContentView.swift
//  MeasureIt
//
//  Created by eren on 23.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var measureVal : Double = 0.0
    @State private var measureType : String = "km"
    @State private var measuredType : String = "m"
    
    private let conversionTable : [String : [String : Double]] = [
        
        "m" : ["m" : 1, "km" : 0.001, "foot": 3.2808, "yard": 1.0936, "mil": 0.0006],
        "km" : ["m" :1000, "km": 1, "foot": 3280.8398, "yard": 1093.6132,"mil":  0.6213 ],
        "foot": ["m": 0.3048, "km": 0.0003, "foot": 1, "yard": 0.3333, "mil": 0.0001 ],
        "yard": ["m": 0.9144, "km": 0.0009144, "foot": 3, "yard": 1, "mil": 0.00056],
        "mil": ["m": 1609.344, "km": 1.609344, "foot": 5280, "yard": 1760, "mil": 1]
    
    ]
    private var measuredVal : Double {
        return CalculateMeasure(measure: measureVal, mt1: measureType, mt2: measuredType)
    }

    
    
    private func CalculateMeasure(measure: Double, mt1: String, mt2: String) -> Double {
        if let conversionRates = conversionTable[mt1], let conversionRate = conversionRates[mt2] {
            return measure * conversionRate
        } else {
            return 0.0
        }
    }

    private let measureTypes : [String] = ["m","km","foot","yard","mil"]
    
    @FocusState private var isFocused : Bool
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                
                Section("measure type"){
                    Picker("Measure Types", selection: $measureType ){
                        ForEach(measureTypes, id: \.self){
                            Text("\($0)")
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    
                    
                }
                
                Section("Amount"){
                    
                    TextField("Enter the amount", value:$measureVal, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                }
                
                Section("Measure to"){
                    Picker("Measured Types", selection: $measuredType ){
                        ForEach(measureTypes, id: \.self){
                            Text("\($0)")
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Text("\(measureVal.formatted()) \(measureType) is \(measuredVal.formatted()) \(measuredType)")
                
                
            }
            .navigationTitle("Measure IT")
            .toolbar{
                if isFocused{
                    Button("Done"){
                        isFocused.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
