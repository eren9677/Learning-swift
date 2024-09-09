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
    
    @State private var errorTitle: String = ""
    @State private var errorMessage : String = ""
    @State private var showError : Bool = false
    
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
            .alert(errorTitle, isPresented: $showError){
                Button("OK"){}
            }message: {
                Text(errorMessage)
            }
        }
    }
    
    func isOriginal(_ word : String) -> Bool{
        !usedWords.contains(word)
    }
    func isPossible(_ word : String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
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
    
    
    func testStrings(_ word : String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        var allGood = misspelled.location == NSNotFound
        return allGood
    }
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(newWord) else {
            WordError(title: "Word is Used", message: "Be more original.")
            return
        }
        guard isPossible(newWord) else {
            WordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }
        guard testStrings(newWord) else {
            WordError(title: "There is no Such word.", message: "you can't make up the words.")
            return
        }
        
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
    

    func WordError(title : String, message : String ){
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

#Preview {
    ContentView()
}
