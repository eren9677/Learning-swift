//
//  ContentView.swift
//  IExpense
//
//  Created by eren on 11.09.2024.
//

import SwiftUI
 // this example wil show passing data between views using classes and an observable keyword.
struct SecondView : View {
    @Environment(\.dismiss) var dismiss
    
    @State private var currentNumber : Int =  1
    @State private var numbers: [Int] = []
    
    private func updateRows(){
        numbers.append(currentNumber)
        currentNumber += 1
    }
    func deleteRows(at offset : IndexSet){
        numbers.remove(atOffsets: offset)
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(numbers, id: \.self){
                    Text("Row \($0)")
                }
                .onDelete(perform:withAnimation{
                    deleteRows}
                )
            }
            Spacer()
            
            Text("hello from second sheet!").padding()
            
            
            
            Spacer()
            HStack {
                Button("dismiss"){
                    dismiss()
                }.padding()
                Spacer()
                Button("Add Rows"){
                    withAnimation{
                        updateRows()
                    }
                }.padding()
            }
            .navigationTitle("Second View")
        }
    }
}
struct ContentView: View {
    @State private var showingSheet : Bool = false
    var body: some View {
        
        VStack{
            Button("Show sheet"){
                showingSheet.toggle()
            }
        }
        .padding()
        .sheet(isPresented: $showingSheet, content: {
            SecondView()
        })
            
    }
}

#Preview {
    ContentView()
}
