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
    var body: some View {
        Text("hello from second sheet!")
        Button("dismiss"){
            dismiss()
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
