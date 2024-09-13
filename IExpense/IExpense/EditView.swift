//
//  EditView.swift
//  IExpense
//
//  Created by eren on 13.09.2024.
//

import SwiftUI

struct EditView: View {
    @State private var name : String = ""
    @State private var type : String = "Personal"
    @State private var amount : Double = 0.0
    private let types : [String] = ["Personal","Business"]
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Enter name of the expense", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "TRY") ).keyboardType(.numberPad)
            }
        }
    }
}

#Preview {
    EditView()
}
