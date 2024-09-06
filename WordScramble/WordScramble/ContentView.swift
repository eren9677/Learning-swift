//
//  ContentView.swift
//  WordScramble
//
//  Created by eren on 6.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var usedWords : [String] = [String]()
    
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Please Enter your word", text: $newWord)
                }
                Section{
                    ForEach(usedWords, id: \.self){word in
                        Text(word)
                    }
                }
            }
            .navigationTitle(rootWord)
        }
    }
    
    func testUrls() {
        if let bundleUrl = Bundle.main.url(forResource: "deneme", withExtension: "txt"){
            
            if let bundleContent = try? String(contentsOf: bundleUrl){
                print("content is found : \(bundleContent)")
            }
            else{
                print("there is no content in bundle!")
            }
            
        }else{
            print("Bundle url can not be found !")
        }
    }
    
    
    func testStrings(){
        let  word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "EN")
        
        var allGood = misspelled.location == NSNotFound
        
        //this code checks if a misspell is found or not in a range
        
        
    }
}

#Preview {
    ContentView()
}
