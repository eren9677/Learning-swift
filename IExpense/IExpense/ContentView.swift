//
//  ContentView.swift
//  IExpense
//
//  Created by eren on 11.09.2024.
//

import SwiftUI
 // this example wil show passing data between views using classes and an observable keyword.


struct ExpenseItem : Identifiable { //means “this type can be identified uniquely.” we can just use this in a foreach wihout  specifying id: \.id
    //it willl automatically get itWs
    
    let id : UUID = UUID() //this function creates a uuid universal unique id to help our swiftui view to help them identify işt.
    let name: String
    let type : String
    let amount : Double
}


struct Expenses {
    var items : [ExpenseItem] = [ExpenseItem]()
}



struct SecondView : View {
    @Environment(\.dismiss) var dismiss
    
    @State private var expenses = Expenses()
    
    private func addExpense(){
        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 2)
        expenses.items.append(expense)
    }
    private func deleteExpense(at offsets : IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            List{
                ForEach(expenses.items){ item in
                    Text(item.name)
                }.onDelete(perform: deleteExpense)
            }
            
            
            
            Spacer()
            HStack {
                Button("dismiss"){
                    dismiss()
                }.padding()
            }
            .navigationTitle("IExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus"){
                    addExpense()
                }
            }
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
