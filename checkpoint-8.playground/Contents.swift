// this checkpoint is mainly about protocols extensions and protocol extensions.

protocol Building {
    var name : String {get set}
    var cost : Int {get set}
    var room : Int {get set}
    func BuildingSummary() -> String
}

//builging a house

struct House : Building{
    var name: String
    var cost: Int
    var room: Int
    func BuildingSummary() -> String {
        
       return  """
        this building's name is \(name )
        and it costs \(cost)$ and has \(room) rooms
       """
    }
}

struct Office : Building{
    var name: String
    var cost: Int
    var room: Int
    func BuildingSummary() -> String {
        
       return  """
        this building's name is \(name )
        and it costs \(cost)$ and has \(room) rooms
       """
    }
}

var house1 = House(name: "Erenin yazlık ada evi", cost: 5_000_000, room: 10)
var office1 = Office(name: "Erenin unicorn şirketi", cost: 10_000_000_000, room: 500)
print(house1.BuildingSummary())
print(office1.BuildingSummary())

