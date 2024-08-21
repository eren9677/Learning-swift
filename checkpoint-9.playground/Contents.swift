//in this checkpoint i willl do a mini exercise with optionals and  nil coalescing.

extension Int {
    func cube() -> Int { //this helps us to use this function on all int types !!! this is fckn helpful
        return  self * self * self
    }
    
}
var deneme_number : Int? = 42

if let deneme = deneme_number {
    
    //this technique is called shadowing
    
    deneme.cube()
    
    //this technique is called shadowing
} else {
    print("optional was empty.")
}
