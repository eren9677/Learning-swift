class Animal {
    var legs : Int = 4
    
    
}

class Dog : Animal {
    func speak(){
        print("Bark! Imma dog ")
    }
}

final class Golden : Dog {
    override func speak(){
        print("Bark imma golden")
    }
}

class  Cat : Animal {
    var isTame : Bool  = false
    
    init( isTame: Bool) {
        self.isTame = isTame
      }

    func speak (){
        print("Meoww! ik ben een katze ! an ik heb \(super.legs) leggen")
    }
}
final class Persian : Cat {
    override func speak(){
        print("meow but actually we are not arabs i also have \(super.legs) legs")
    }
}



let oreo = Golden()
oreo.speak() // aaarf

let mocha = Persian(isTame: true)
mocha.speak() // meeoOow
print(mocha.isTame) // true
Dog().speak()
Golden().speak()
Cat(isTame: true).speak()
