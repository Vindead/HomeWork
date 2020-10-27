import UIKit

/*1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.*/


class Android {
    var model : String
    var yearManufacture : Int
    var cost: Int
    
    init(model : String, yearManufacture : Int, cost: Int) {
        self.model = model
        self.yearManufacture = yearManufacture
        self.cost = cost
    }
}

class Ios {
    var model : String
    var yearManufacture : Int
    var cost: Int
    
    init(model : String, yearManufacture : Int, cost: Int) {
        self.model = model
        self.yearManufacture = yearManufacture
        self.cost = cost
    }
}



struct Queue<T> {
    private  var store: [T] = []
    mutating func push(_ element: T) {
        store.append(element)
    }
    
    mutating func pop () -> T? {
        guard store.count > 0 else { return nil}
        print(" Устройство \(store.first) куплено ")
        return store.removeFirst()
    }
    func result (){
        print( print(" В магазине  \(self.store.count) устройств(а)" ))
    }
    
    func filter (predicate: (T)-> Bool)-> [T]{
        var  tmpArray = [T] ()
        for item in store{
            if predicate (item){
                tmpArray.append(item)
            }
        }
        return tmpArray
    }
}

var samsungGalaxy10 = Android(model: "Samsung GAlaxy 10", yearManufacture: 2019, cost: 41000)
var xiaomiRedmiNote = Android(model: "XiaomiRedmiNote", yearManufacture: 2015, cost: 14900)
var huaweiP40 = Android(model: "HuaweiP40", yearManufacture: 2018, cost: 31900)
var iphone11 = Ios(model: "Iphone 11", yearManufacture: 2019, cost: 59000)
var iphone11Pro = Ios(model: "Iphone11Pro", yearManufacture: 2019, cost: 79000)
var iphone11ProMax = Ios (model: "Iphone11ProMax", yearManufacture: 2019, cost: 96000)


// создаем две очереди Андроид и Айфон в которых будем хранить телефоны

var queueAndroid = Queue<Android>()
var queueIphone = Queue<Ios>()


// Добавляем элементы в коллецию (Очередь)
queueAndroid.push(Android(model: "Samsung GAlaxy 10", yearManufacture: 2019, cost: 41000))
queueAndroid.push(Android(model: "XiaomiRedmiNote", yearManufacture: 2015, cost: 14900))
queueAndroid.push(Android(model: "HuaweiP40", yearManufacture: 2018, cost: 31900))


queueIphone.push(Ios(model: "Iphone 11", yearManufacture: 2019, cost: 59000))
queueIphone.push (Ios(model: "Iphone11Pro", yearManufacture: 2019, cost: 79000))
queueIphone.push (Ios (model: "Iphone11ProMax", yearManufacture: 2019, cost: 96000))
queueIphone.result()
queueIphone.result()

let filtredPhones = queueIphone.filter{
    return $0.cost < 80000}
print(filtredPhones)

let filtredAndroid = queueAndroid.filter{
    return $0.yearManufacture < 2018}
print(filtredAndroid)

