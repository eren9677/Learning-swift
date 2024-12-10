//
//  ContentView.swift
//  ConvertIT
//
//  Created by eren on 10/12/2024.
//

import SwiftUI
//this app will convert temperature measurements.
struct ContentView: View {
    
    @State private var temperature: Double = 0
    @State private var selectedUnit: String = "Celcius"
    @State private var units: [String] = ["Celcius", "Fahrenheit", "Kelvin"]
    @State private var toBeConverted: String = "Celcius"
    @FocusState private var focused: Bool
    @State private var conversionMatrix: [String: [String: (Double) -> Double]] = [
        "Celcius": [
            "Fahrenheit": { celsius in (celsius * 9/5) + 32 },
            "Kelvin": { celsius in celsius + 273.15 },
            "Celcius": { celsius in celsius }
        ],
        "Fahrenheit": [
            "Celcius": { fahrenheit in (fahrenheit - 32) * 5/9 },
            "Kelvin": { fahrenheit in (fahrenheit - 32) * 5/9 + 273.15 },
            "Fahrenheit": { fahrenheit in fahrenheit }
        ],
        "Kelvin": [
            "Celcius": { kelvin in kelvin - 273.15 },
            "Fahrenheit": { kelvin in (kelvin - 273.15) * 9/5 + 32 },
            "Kelvin": { kelvin in kelvin }
        ]
    ]

    func calculateConversion(temperature: Double, from selectedUnit: String, to targetUnit: String) -> Double {
        guard let unitConversions = conversionMatrix[selectedUnit],
              let conversion = unitConversions[targetUnit] else {
            return temperature
        }
        
        return conversion(temperature)
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section("Enter the temperature"){
                    HStack {
                        TextField("Enter temperature", value: $temperature, format: .number)
                            .keyboardType(.numberPad)
                            .focused($focused)
                        Picker("",selection: $selectedUnit) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                    }
                }
                Section("Select the Conversion Unit"){
                    HStack {
                        //select the conversion unit
                        Picker("",selection: $toBeConverted) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit)
                            }
                        }.pickerStyle(.segmented)
                    }
                }
                
                Section("Converted Temperature"){
                    Text("\( calculateConversion(temperature: temperature, from: selectedUnit, to: toBeConverted).formatted(.number.precision(.fractionLength(3)))) \(toBeConverted)")
                }
                
                
            }
            .navigationTitle("Convert Temperatures")
            .toolbar {
                if focused {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done"){
                                self.focused.toggle()
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }

                
    }

#Preview {
    ContentView()
}
