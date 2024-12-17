//
//  ContentView.swift
//  ObesityCheck
//
//  Created by eren on 16/12/2024.
//

import SwiftUI
import CoreML

struct BlockIt: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.thinMaterial)
            .clipShape(.rect(cornerSize: .init(width: 50, height: 50)))
            .clipShape(.rect(cornerRadius: 30))
            .padding()
            .padding(.bottom,20)
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

struct SinglePickerView: View {
    let question: String
    let options: [String]
    @Binding var selection: String
    
    var body: some View {
        HStack {
            Question(question: question)
            Spacer()
            Picker("Select", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text("\(option)")
                }
            }
            .padding(.horizontal)
            .pickerStyle(.menu)
        }
    }
}

struct WheelPickerView: View {
    let question: String
    let start: Int
    let end: Int
    @Binding var selection: Int
    
    var body: some View {
        HStack {
            Question(question: question)
            Spacer()
            Text("\(selection)")
            Picker("Select", selection: $selection) {
                ForEach(start..<end, id: \.self){
                    Text("\($0)")
                }
            }
            .pickerStyle(.wheel)
            .frame(width:100, height:100)
        }
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
    //@FocusState private var isFocused: Bool
    
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
    
    //in this line i will put in an array all the selectedvalues such as selectedGender
    private var allselectedValues: [String] {
        [selectedCalorieTracking, selectedConsumptionOfFastFood, selectedDailyLiquidExcretion, selectedFamilyMembersObese, selectedFoodIntakeBetweenMeals, selectedFrequencyOfConsumptionOfVegetables, selectedGender, selectedNumberOfMainMealsDaily, selectedPhysicalExercise, selectedScheduleDedicatedToTechnology, selectedSmoke, selectedTypeOfTransportation]
    }
    
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
    private var parameterNames : [String] {
        Array(conversionMatrix.keys).sorted()
    }
    
    @State private var alertTitle = ""
    
//    private func calculateObesity(parameters: [String], values:[String]) -> Int64{
//        var normalized: [Int64] = []
//        var pred: Int64 = 0
//        
//        for (parameterName, value) in zip(parameters,values) {
//            guard let conversionName = conversionMatrix[parameterName],
//            let numerical = conversionName[value] else{
//                return 0
//            }
//            normalized.append(Int64(numerical))
//            
//            do{
//                let config = MLModelConfiguration()
//                let model = try ObesityModel_1(configuration: config)
//                
//                let prediction = try model.prediction(Age: Int64(age), Calculation_of_Calorie_Intake: normalized[0], Consumption_of_Fast_Food: normalized[1], Food_Intake_Between_Meals: normalized[4], Frequency_of_Consuming_Vegetables: normalized[5], Height: Int64(height), Liquid_Intake_Daily: normalized[2], Number_of_Main_Meals_Daily: normalized[7], Overweight_Obese_Family: normalized[3], Physical_Excercise: normalized[8], Schedule_Dedicated_to_Technology: normalized[9], Sex: normalized[6], Smoking: normalized[10], Type_of_Transportation_Used: normalized[11])
//                
//                switch prediction.Class_{
//                case 1:
//                    alertTitle = "Underweight"
//                
//                case 2:
//                    alertTitle = "Normal"
//                
//                case 3:
//                    alertTitle = "Overweight"
//                
//                case 4:
//                    alertTitle = "Obesity"
//                default:
//                    alertTitle = "Weird Prediction"
//                }
//                pred = prediction.Class_
//                
//            }
//            catch{
//                alertTitle = "Error"
//            }
//            
//        }
//        return pred
//    }
//   
    private func calculateObesity(parameters: [String], values: [String]) -> Int64 {
        var normalized: [Int64] = []
        
        guard parameters.count == values.count else {
            alertTitle = "Error: Parameters and values do not match."
            return 0
        }
        for (parameterName, value) in zip(parameters,values) {
            guard let conversionName = conversionMatrix[parameterName],
                  let numerical = conversionName[value] else{
                return 0
            }
            normalized.append(Int64(numerical))
        }

        
        // Validate that normalized contains the expected 12 elements
        guard normalized.count == 12 else {
            alertTitle = "Error: Missing or invalid parameters."
            print(alertTitle)
            return 0
        }
        
        
        do {
            let config = MLModelConfiguration()
            let model = try ObesityModel_1(configuration: config)
            
            let prediction = try model.prediction(Age: Int64(age), Calculation_of_Calorie_Intake: normalized[0], Consumption_of_Fast_Food: normalized[1], Food_Intake_Between_Meals: normalized[4], Frequency_of_Consuming_Vegetables: normalized[5], Height: Int64(height), Liquid_Intake_Daily: normalized[2], Number_of_Main_Meals_Daily: normalized[7], Overweight_Obese_Family: normalized[3], Physical_Excercise: normalized[8], Schedule_Dedicated_to_Technology: normalized[9], Sex: normalized[6], Smoking: normalized[10], Type_of_Transportation_Used: normalized[11])
            
            switch prediction.Class_ {
            case 1:
                alertTitle = "Underweight"
            case 2:
                alertTitle = "Normal"
            case 3:
                alertTitle = "Overweight"
            case 4:
                alertTitle = "Obesity"
            default:
                alertTitle = "Weird Prediction"
            }
            print(alertTitle)
            return prediction.Class_
        } catch {
            alertTitle = "Model error: \(error.localizedDescription)"
            print(alertTitle)
            return 0
        }
    }
    
    
    @State private var result: Int64 = 0
    @State private var showResult: Bool = false
    
    
    let questions : [String] = [
        "What is your gender?",
        "Are your Family members obese?",
        "Do you Consume Fast Food?",
        "How often do you consume vegetables?",
        "How many main meals do you have in a day?",
        "How often do you eat between meals?",
        "Do you smoke?",
        "How much do you drink water per day?",
        
        
        
    ]
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing).ignoresSafeArea(.all)
                
                ScrollView{
                    
                    VStack{
                        
                        
//                        HStack {
//                            Question(question:"What is your gender?")
//                            Spacer()
//                            Picker("select gender",selection: $selectedGender){
//                                ForEach(genders, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
                        SinglePickerView(question: "What is your gender?", options: genders, selection: $selectedGender)
                        
//                        HStack {
//                            Question(question: "What is your age?")
//                            Spacer()
//                            Text("\(age)")
//                                .padding(.horizontal)
//                            Stepper("age", value: $age, in: 0...100, step:1)
//                                .labelsHidden()
//                                .padding(.horizontal)
//                        }
//
                        WheelPickerView(question: "What is your age?", start: 0, end: 100, selection: $age)
//                        HStack{
//                            Question(question: "What is your height?")
//                            Spacer()
//                            Text("\(height) cm")
//                                .padding(.horizontal)
//                            Picker("Select height", selection: $height){
//                                ForEach(1..<210, id: \.self){
//                                    Text("\($0)")
//                                }
//                                
//                            }.pickerStyle(.wheel)
//                                .frame(width:100, height:100)
                        
                        WheelPickerView(question: "What is your height?", start: 0, end: 210, selection: $height)
//                            TextField("Enter height", value: $height, format: .number)
//                                .padding([.vertical],10)
//                                .fixedSize()
//                                .labelsHidden()
//                                .multilineTextAlignment(.center)
//                                .background(.ultraThinMaterial)
//                                .clipShape(.rect(cornerRadius: 15))
//                                .padding(.horizontal)
//                                .focused($isFocused)
//                                .keyboardType(.numberPad)
//                        }
                        
//                        HStack {
//                            Question(question:"Are your family members obese?")
//                            Spacer()
//                            Picker("select",selection: $selectedFamilyMembersObese){
//                                ForEach(familyMembersObese, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
                        SinglePickerView(question:"Are your family members obese?", options: familyMembersObese, selection: $selectedFamilyMembersObese)
//                        HStack {
//                            Question(question:"Do you Consume Fast Food?")
//                            Spacer()
//                            Picker("select",selection: $selectedConsumptionOfFastFood){
//                                ForEach(consumptionOfFastFood, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
                        SinglePickerView(question:"Do you Consume Fast Food?", options: consumptionOfFastFood, selection: $selectedConsumptionOfFastFood)
                        
//                        HStack {
//                            Question(question:"How often do you consume vegetables?")
//                            Spacer()
//                            Picker("select ",selection: $selectedFrequencyOfConsumptionOfVegetables){
//                                ForEach(frequencyOfConsumptionOfVegetables, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
                        SinglePickerView(question:"How often do you consume vegetables?", options: frequencyOfConsumptionOfVegetables, selection: $selectedFrequencyOfConsumptionOfVegetables)
                        
//                        HStack {
//                            Question(question:"How many main meals do you have in a day?")
//                            Spacer()
//                            Picker("select",selection: $selectedNumberOfMainMealsDaily){
//                                ForEach(numberOfMainMealsDaily, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
                        SinglePickerView(question:"How many main meals do you have in a day?", options: numberOfMainMealsDaily, selection: $selectedNumberOfMainMealsDaily)
                        
                        
//                        HStack {
//                            Question(question:"How often do you eat between meals?")
//                            Spacer()
//                            Picker("select",selection: $selectedFoodIntakeBetweenMeals){
//                                ForEach(foodIntakeBetweenMeals, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
                        SinglePickerView(question:"How often do you eat between meals?", options: foodIntakeBetweenMeals, selection: $selectedFoodIntakeBetweenMeals)
                        
//                        HStack {
//                            Question(question:"Do you smoke?")
//                            Spacer()
//                            Picker("select",selection: $selectedSmoke){
//                                ForEach(smoke, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
                        SinglePickerView(question:"Do you smoke?", options: smoke, selection: $selectedSmoke)
//                        HStack {
//                            Question(question:"How much do you drink water per day?")
//                            Spacer()
//                            Picker("select",selection: $selectedDailyLiquidExcretion){
//                                ForEach(dailyLiquidExcretion, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
                        SinglePickerView(question:"How much do you drink water per day?", options: dailyLiquidExcretion, selection: $selectedDailyLiquidExcretion)
                        
//                        HStack {
//                            Question(question:"Do you track your calories?")
//                            Spacer()
//                            Picker("select",selection: $selectedCalorieTracking){
//                                ForEach(calorieTracking, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
                        SinglePickerView(question:"Do you track your calories?", options: calorieTracking, selection: $selectedCalorieTracking)
                        
//                        HStack {
//                            Question(question:"How much physical activity do you do?")
//                            Spacer()
//                            Picker("select",selection: $selectedPhysicalExercise){
//                                ForEach(physicalExercise, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
                        SinglePickerView(question:"How much physical activity do you do?", options: physicalExercise, selection: $selectedPhysicalExercise)
//                        HStack {
//                            Question(question:"How much do use use your phone in a day?")
//                            Spacer()
//                            Picker("select",selection: $selectedScheduleDedicatedToTechnology){
//                                ForEach(scheduleDedicatedToTechnology, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
                        SinglePickerView(question:"How much do use use your phone in a day?", options: scheduleDedicatedToTechnology, selection: $selectedScheduleDedicatedToTechnology)
                        
//                        HStack {
//                            Question(question:"What type of transportation you use most often? ")
//                            Spacer()
//                            Picker("select",selection: $selectedTypeOfTransportation){
//                                ForEach(typeOfTransportation, id: \.self){
//                                    Text($0)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
                        SinglePickerView(question:"What type of transportation you use most often? ", options: typeOfTransportation, selection: $selectedTypeOfTransportation)
                        //calculation button
                        
                        Button(action: {
                                                   print("\nAll selected values at calculation:")
                                                   print(allselectedValues)
                                                   print("\nParameter names:")
                                                   print(parameterNames)
                                                   result = calculateObesity(parameters: parameterNames, values: allselectedValues)
                                                   showResult = true
                                               }) {
                                                   Text("Calculate")
                                                       .font(.headline)
                                                       .foregroundColor(.white)
                                                       .padding()
                                                       .frame(maxWidth: .infinity)
                                                       .background(Color.blue)
                                                       .cornerRadius(10)
                                               }
                                               .padding()
                                               
                                               if showResult {
                                                   if alertTitle == "Normal"{
                                                       Text(alertTitle)
                                                           .font(.title2)
                                                           .padding()
                                                           .foregroundColor(.white)
                                                           .background(Color.green.opacity(0.7))
                                                           .cornerRadius(10)
                                                           .padding()
                                                   }
                                                   else {
                                                       Text(alertTitle)
                                                           .font(.title2)
                                                           .padding()
                                                           .foregroundColor(.white)
                                                           .background(Color.red.opacity(0.7))
                                                           .cornerRadius(10)
                                                           .padding()
                                                   }
                                               }
                        
                        
                    }.blockIt()

                }.toolbarBackground(.ultraThinMaterial)
                .navigationTitle("Obesity Check")
//                .toolbar {
//                    if isFocused {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button("Done") {
//                                isFocused = false
//                            }
//                            .frame(width: 40)
//                            .padding([.horizontal],10)
//                            .safeAreaPadding(.init(top: 2, leading: 5, bottom: 2, trailing: 10))
//                            .background(.thinMaterial)
//                            .clipShape(.rect(cornerRadius: 15))
//                        }
//                    }
//                }
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
