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
 


// Your challenge is this: write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.


func SimpleFunction(_ arr : [Int]?) -> Int {
    return arr?.randomElement() ?? Int.random(in: 1...100)
}
SimpleFunction([3,4,5,6,7,8,9,])
SimpleFunction(nil)
SimpleFunction([])
