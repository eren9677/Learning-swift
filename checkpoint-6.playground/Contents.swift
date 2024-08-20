enum AmountError : Error{
    case NoEnoughFunds, NegativeInteger
}



struct BankAccount {
    var funds : Int = 0
    
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

var account1 = BankAccount(funds: 3_000)



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

