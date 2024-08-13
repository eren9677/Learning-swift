enum NumberError : Error{
    case OutOfBounds, NoSquareRoot
}

func own_sqrt(_ number: Int) throws -> Int{
    if number < 1 || number > 10000 {throw NumberError.OutOfBounds}
    
    for i in 1...100{
        if(i*i == number){
            return i
        }
    }
    throw NumberError.NoSquareRoot
}

do {
    let result = try own_sqrt(25)
}
catch NumberError.OutOfBounds{
    print("the given number is out of the bounds!")
    }
catch NumberError.NoSquareRoot{
    print("No integer square root of that number!")
    }

