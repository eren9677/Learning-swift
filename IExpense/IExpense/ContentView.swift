//
//  ContentView.swift
//  IExpense
//
//  Created by eren on 11.09.2024.
//

import SwiftUI
 // this example wil show passing data between views using classes and an observable keyword.


struct ExpenseItem : Identifiable, Codable{ //means “this type can be identified uniquely.” we can just use this in a foreach wihout  specifying id: \.id
    //it willl automatically get itWs
    
    var id : UUID = UUID() //this function creates a uuid universal unique id to help our swiftui view to help them identify işt.
    let name: String
    let type : String
    let amount : Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}




struct SecondView : View {
    @Environment(\.dismiss) var dismiss
    
    @State private var expenses = Expenses()
    @State private var showingEditView : Bool = false
    
    private func addExpense(){
        showingEditView.toggle()
    }
    private func deleteExpense(at offsets : IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            List{
                ForEach(expenses.items){ item in
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "TRY"))
                    }
                    
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
                .sheet(isPresented: $showingEditView){
                    EditView(expenses: expenses)
                }
                
            }
        }
    }
}
struct ContentView: View {
    @State private var showingSheet : Bool = false
    var body: some View {
        
        VStack{
            Button("Show Expenses"){
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
