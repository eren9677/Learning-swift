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
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                withAnimation{addNewWord()}
            }
            .onAppear(perform: startGame)
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
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame(){
        if let textUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            
            if let textContent = try? String(contentsOf: textUrl){
                let allWords = textContent.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
            }else {
                fatalError("bunde is corrupted!")
            }
            
        }else{
            fatalError("Error. bundle can not be found. ")
        }
    }
}

#Preview {
    ContentView()
}
