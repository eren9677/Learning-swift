//this check point is to find the lucky numbers inside an array.

let LuckyNumbers : [Int] = [7,4,38,21,16,15,12,33,31,49]

//filtering the even numbers :
var result : [Int] = LuckyNumbers.filter{
    $0%2 != 0
}.sorted(by: <)
//sprting the array in ascending order:

var answer : [String] = result.map{
    "\($0) is a lucky number"
}

for a in answer{
    print("\(a)")
}
