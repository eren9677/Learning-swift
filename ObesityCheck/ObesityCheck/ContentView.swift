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
   // init() {
       // UINavigationBar.appearance().barTintColor = .purple // Uses UIColor
     // }
      
    
    @State private var genders: [String] = ["Male", "Female"]
    @State private var selectedGender: String = "Male"
    
    @State private var age: Int = 0
    
    @State private var height: Int = 0
    @FocusState private var isFocused: Bool
    
    @State private var familyMembersObese: [String] = ["Yes", "No"]
    @State private var selectedFamilyMembersObese: String = "No"
    
    @State private var consumptionOfFastFood: [String] = ["Yes", "No"]
    @State private var selectedConsumptionOfFastFood: String = "No"
    
    @State private var frequencyOfConsumptionOfVegetables: [String] = ["Rarely", "Sometimes", "Once a Week"]
    @State private var selectedFrequencyOfConsumptionOfVegetables: String = "Rarely"
    
    @State private var numberOfMainMealsDaily: [String] = ["1-2","3","3+"]
    @State private var selectedNumberOfMainMealsDaily: String = "3"
    
    @State private var foodIntakeBetweenMeals: [String] = ["Rarely","Sometimes","Usually","Always"]
    @State private var selectedFoodIntakeBetweenMeals: String = "Rarely"
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea(.all)
                
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
                        
                        HStack {
                            Question(question:"Are your family members obese?")
                            Spacer()
                            Picker("select",selection: $selectedFamilyMembersObese){
                                ForEach(familyMembersObese, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"Do you Consume Fast Food?")
                            Spacer()
                            Picker("select",selection: $selectedConsumptionOfFastFood){
                                ForEach(consumptionOfFastFood, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"How often do you consume vegetables?")
                            Spacer()
                            Picker("select ",selection: $selectedFrequencyOfConsumptionOfVegetables){
                                ForEach(frequencyOfConsumptionOfVegetables, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"How many main meals do you have in a day?")
                            Spacer()
                            Picker("select",selection: $selectedNumberOfMainMealsDaily){
                                ForEach(numberOfMainMealsDaily, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        
                    }.blockIt()

                }.toolbarBackground(.ultraThinMaterial) //this changes the background of toolbar.
                .navigationTitle("Obesity Check")
                .toolbar {
                    if isFocused {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                isFocused = false
                            }
                            .frame(width: 40)
                            .padding([.horizontal],10)
                            .clipShape(.rect(cornerRadius: 15))
                            .background(.thinMaterial)
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
