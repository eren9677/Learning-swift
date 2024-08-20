enum AmountError : Error{
    case NoEnoughFunds, NegativeInteger
}



struct BankAccount {
    private var funds : Int = 0
    
    mutating func Deposit(amount:Int){
        funds += amount
    }
    
    mutating func Withdraw(amount: Int) throws -> Bool{
        
        if(amount < 0){throw AmountError.NegativeInteger}
        
        if(funds >= amount){
            funds -= amount
            return true
        }
        else{
            throw AmountError.NoEnoughFunds
        }
    }
    
    func ShowFunds(){
        print(funds)
    }
    
}

var account1 = BankAccount()

account1.Deposit(amount: 3_000)

do {
    account1.Deposit(amount: 300)
    try account1.Withdraw(amount: 3000)
    account1.ShowFunds()

    try account1.Withdraw(amount: 300)

    
    try account1.Withdraw(amount: -50)
}
catch AmountError.NegativeInteger{
    print("You can not do operation with a negative integer!")
    
}
catch AmountError.NoEnoughFunds {
    print("Not Enough funds for that action")
}


print("checking if this line will execute ? ")


enum CarError : Error {
    case GearOutOfRange
}

struct Car {
    let model: String
    let seats: Int
    private(set) var current_gear : Int = 1 {
        didSet {
            print("The \(model) was in gear: \(oldValue) new gear : \(current_gear)")
        }
    }
    
    enum Gear {
        case up , down , neutral
    }
    
    public mutating func ChangeGear(_ direction: Gear) throws{
        switch direction {
        case .up :  
            if (current_gear <= 9) { current_gear += 1 }
            else {throw CarError.GearOutOfRange}
        case .down :
            if (current_gear > 1) { current_gear -= 1 }
            else {throw CarError.GearOutOfRange}
        case .neutral :  current_gear = 1
        }
    }
}



do {
    var car1 = Car( model: "Porsche", seats: 2, current_gear: 4)
    for _ in 1...6 {
        try car1.ChangeGear(.up)
    }
    
    var car2 = Car(model: "lambo", seats: 2, current_gear: 3)
    
    for _ in 1...4 {
        try car2.ChangeGear(.down)
    }
    
}
catch CarError.GearOutOfRange { print("Gear is Out of range !!") }
