//
//  ContentView.swift
//  ObesityCheck
//
//  Created by eren on 16/12/2024.
//

import SwiftUI

struct BlockIt: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth:.infinity)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 15))
            .padding()
    }
}

extension View {
    func blockIt() -> some View {
        modifier(BlockIt())
    }
}
struct Question: View {
    var question: String
    var body : some View {
        Text(question).font(.title2.weight(.bold)).padding()
    }
}

struct ContentView: View {
    
    @State private var genders: [String] = ["Male", "Female"]
    @State private var selectedGender: String = "Male"
    
    @State private var age: Int = 0
    
    @State private var height: Int = 0
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
                
                ScrollView{
                    
                    VStack{
                        
                        HStack {
                            Question(question:"What is your gender?")
                            Spacer()
                            Picker("select gender",selection: $selectedGender){
                                ForEach(genders, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question: "What is your age?")
                            Spacer()
                            Text("\(age)")
                                .padding(.horizontal)
                            Stepper("age", value: $age, in: 0...100, step:1)
                                .labelsHidden()
                                .padding(.horizontal)
                        }
                        
                        HStack{
                            Question(question: "What is your height?")
                            Spacer()
                            Text("\(height) cm")
                                .padding(.horizontal)
                            TextField("Enter height", value: $height, format: .number)
                                .padding([.vertical],10)
                                .fixedSize()
                                .labelsHidden()
                                .multilineTextAlignment(.center)
                                .background(.ultraThinMaterial)
                                .clipShape(.rect(cornerRadius: 15))
                                .padding(.horizontal)
                                .focused($isFocused)
                                .keyboardType(.numberPad)
                        }
                        
                        
                        
                    }.blockIt()

                }
                .navigationTitle("Obesity Check")
                .toolbar {
                    if isFocused {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                isFocused = false
                            }
                            .fixedSize()
                            .frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius: 15))
                            .background(.thinMaterial)
                            .padding([.horizontal],10)
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
