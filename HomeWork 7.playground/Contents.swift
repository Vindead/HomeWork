import UIKit

/*1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error. */
enum PossibleErrows : Error{
   case invalidSelection
    case NotInStock
    case NotEnoughtMoney (moneyneeded : Double)
}
struct Product {
    var name : String
}
struct Fuel {
    var priceOfLiter : Double
    var count : Double
    var product : Product
}

class FuelStation {
    var typeOfFuel = [
        "АИ92": Fuel(priceOfLiter: 42.5, count: 500, product: Product(name: "АИ92") ),
        "АИ95": Fuel(priceOfLiter: 49.00, count: 1000, product: Product(name: "АИ95")),
        "АИ98": Fuel(priceOfLiter: 52.4, count: 800, product: Product(name: "АИ98")),
        "Дизель": Fuel(priceOfLiter: 47.6, count: 800, product: Product(name: "Дизель"))
    ]
    var deposit :Double = 2500.00
    var fuelNeeded : Double = 20.00
    func getTheFuel (FuelName name : String)throws -> Product? {
        guard let fuel = typeOfFuel [name] else {
            throw  PossibleErrows.invalidSelection
        }
        guard fuel.count > 0 else{
            throw PossibleErrows.NotInStock
        }
        guard fuel.priceOfLiter * fuelNeeded <= deposit else {
            throw  PossibleErrows.NotEnoughtMoney(moneyneeded: fuel.priceOfLiter * fuelNeeded - deposit)
        }
        deposit-=fuel.priceOfLiter * fuelNeeded
        var newFuel = fuel
        newFuel.count -= fuelNeeded
        typeOfFuel [name] = newFuel
        
        print("Вы заправились бензином \(name) в кооличестве \(fuelNeeded) литров. Остаток на счете \(deposit). \(name) осталось \(fuel.count - fuelNeeded) литров")
        return newFuel.product
    }
    
}
let fuelStation = FuelStation ()
fuelStation.deposit = 3000
do{
    try fuelStation.getTheFuel(FuelName: "Дизель")
}
catch PossibleErrows.invalidSelection{
    print("Такой марки бензина нет в ассоритменте!")
}
catch PossibleErrows.NotInStock{
    print("Топливо закончилось")
}
catch PossibleErrows.NotEnoughtMoney(let needed){
print("Недостаточно средств! Нужно еще \(needed) рублей")
}
catch let error{
    print(error.localizedDescription)
}

// Евгений попытался реализовать что то наподобии заправочной станции вроде все работает. Но несмотря на то, что что все работает приходится долго разбираться с вычисляемыми свойствами. Предлагаю повторить на кончультации ряд вопросов по крайней мере они меня волнуют.
/*1. Вычисляемые свойства в частности Willset и  Didset.
 2. Также вот если меня спроси про полиморфизм, то я не смогу ответить( тоже хотелос бы повторить)
 3. Ну про замыкания стало понятнее, но всеравно вот если бы пример когда обычная функцией не обойтись а нужно именно замыкания, на практике понимаю многие стараются их обходить.
 4. также про ошибки вот есть конкретный пример я тут сделал проверку, но как мне понять в реальном проекте когда это нужно а когда нет
 5. subscript тоже тема такая которая на ровне с замыканиями не до конца понятна.
 Пока что меня волнуют представленные вопросы))
 */
