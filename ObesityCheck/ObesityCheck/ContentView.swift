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
            .padding()
            .background(.thinMaterial)
            .clipShape(.rect(cornerSize: .init(width: 50, height: 50)))
            .clipShape(.rect(cornerRadius: 30))
            .padding()
            .padding(.bottom,70)
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
    
    @State private var age: Int = 18
    
    @State private var height: Int = 170
    @FocusState private var isFocused: Bool
    
    @State private var familyMembersObese: [String] = ["Yes", "No"]
    @State private var selectedFamilyMembersObese: String = "No"
    
    @State private var consumptionOfFastFood: [String] = ["Yes", "No"]
    @State private var selectedConsumptionOfFastFood: String = "No"
    
    @State private var frequencyOfConsumptionOfVegetables: [String] = ["Rarely", "Sometimes", "Always"]
    @State private var selectedFrequencyOfConsumptionOfVegetables: String = "Rarely"
    
    @State private var numberOfMainMealsDaily: [String] = ["1-2","3","3+"]
    @State private var selectedNumberOfMainMealsDaily: String = "3"
    
    @State private var foodIntakeBetweenMeals: [String] = ["Rarely","Sometimes","Usually","Always"]
    @State private var selectedFoodIntakeBetweenMeals: String = "Rarely"
    
    @State private var smoke: [String] = ["Yes", "No"]
    @State private var selectedSmoke: String = "No"
    
    @State private var dailyLiquidExcretion: [String] = ["Less than 1 liter","1-2 liters","More than 2 Liters"]
    @State private var selectedDailyLiquidExcretion: String = "Less than 1 liter"
    
    @State private var calorieTracking: [String] = ["Yes", "No"]
    @State private var selectedCalorieTracking: String = "No"
    
    @State private var physicalExercise: [String] = ["No physical activity", "1-2 days","3-4 days"," 5-6 days","6+ days"]
    @State private var selectedPhysicalExercise: String = "1-2 days"
    
    @State private var scheduleDedicatedToTechnology: [String] = ["0-2 hours","3-5 hours","5+ hours"]
    @State private var selectedScheduleDedicatedToTechnology: String = "0-2 hours"
    
    @State private var typeOfTransportation: [String] = ["Automobile","Motorbike","Bike","Public Transportation","Walking"]
    @State private var selectedTypeOfTransportation: String = "Automobile"
    
    
    private let conversionMatrix: [String : [String: Int]] = [
        "gender":[
            "Male": 1,
            "Female": 2
        ],
        "familyMembersObese":[
            "Yes": 1,
            "No": 2
        ],
        "consumptionOfFastFood":[
            "Yes": 1,
            "No": 2
        ],
        "frequencyOfConsumptionOfVegetables":[
            "Rarely":1,
            "Sometimes":2,
            "Always":3
        ],
        "numberOfMainMealsDaily":[
            "1-2":1,
            "3":2,
            "3+":3
            ],
        "foodIntakeBetweenMeals":[
            "Rarely":1,
            "Sometimes":2,
            "Usually":3,
            "Always":4
        ],
        "smoke":[
            "Yes":1,
            "No":2
        ],
        "dailyLiquidExcretion": [
            "Less than 1 liter":1,
            "1-2 liters":2,
            "More than 2 Liters":3
        ],
        "calorieTracking":[
            "Yes":1,
            "No":2
        ],
        "physicalExercise":[
            "No physical activity":1,
            "1-2 days":2,
            "3-4 days":3,
            " 5-6 days":4,
            "6+ days":5
        ],
        "scheduleDedicatedToTechnology":[
            "0-2 hours":1,
            "3-5 hours":2,
            "5+ hours":3
            ],
        "typeOfTransportation": [
            "Automobile":1,
            "Motorbike":2,
            "Bike":3,
            "Public Transportation":4,
            "Walking":5
        ]
    ]
    
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
                        
                        HStack {
                            Question(question:"How often do you eat between meals?")
                            Spacer()
                            Picker("select",selection: $selectedFoodIntakeBetweenMeals){
                                ForEach(foodIntakeBetweenMeals, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"Do you smoke?")
                            Spacer()
                            Picker("select",selection: $selectedSmoke){
                                ForEach(smoke, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"How much do you drink water per day?")
                            Spacer()
                            Picker("select",selection: $selectedDailyLiquidExcretion){
                                ForEach(dailyLiquidExcretion, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"Do you track your calories?")
                            Spacer()
                            Picker("select",selection: $selectedCalorieTracking){
                                ForEach(calorieTracking, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"How much physical activity do you do?")
                            Spacer()
                            Picker("select",selection: $selectedPhysicalExercise){
                                ForEach(physicalExercise, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"How much do use use your phone in a day?")
                            Spacer()
                            Picker("select",selection: $selectedScheduleDedicatedToTechnology){
                                ForEach(scheduleDedicatedToTechnology, id: \.self){
                                    Text($0)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Question(question:"What type of transportation you use most often? ")
                            Spacer()
                            Picker("select",selection: $selectedTypeOfTransportation){
                                ForEach(typeOfTransportation, id: \.self){
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
                            .safeAreaPadding(.init(top: 2, leading: 5, bottom: 2, trailing: 10))
                            .background(.thinMaterial)
                            .clipShape(.rect(cornerRadius: 15))
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
