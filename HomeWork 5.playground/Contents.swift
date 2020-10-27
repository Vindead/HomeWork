import UIKit

/*1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
5. Создать несколько объектов каждого класса. Применить к ним различные действия.
6. Вывести сами объекты в консоль. */

enum Transmission {
    case automatic
    case mecanic
}

enum EngineState{
    case start
    case finish
}

enum WindowsState{
    case open
    case closed
}

enum DoorState{
    case open
    case closed
}
// Определим перечесления для спортивного автомобиля

enum SportMode {
    case on
    case off
}

// Определим перечесления для грузового автомобиля

enum RoadWahing{
    case start
    case finish
}

protocol CarProtocol: class{
    var manufature: String { get }
    var year: String { get }
    var transmission: Transmission { get set}
    var power: Int { get }
    var colour: UIColor { get }
    var engineState: EngineState { get set}
    var windowsOpen : WindowsState { get set}
    var doorState: DoorState { get set}
    
    func activeEngine (action: EngineState)
}

// Создадим расширение протокола, реализующий методы
extension  CarProtocol {
    
    func activeEngine (action: EngineState){
        self.engineState = action
        switch action {
        case .start:
            print("Двигатель запущен, можно ехать!")
        case.finish:
            print("Двигатель выключен, поездка окончена!")
        }
    }
    func activeWindows (action: WindowsState){
        self.windowsOpen = action
        switch action {
        case .open:
            print("Окна открыты, жара!")
        case.closed:
            print("Окна закрыты, на улице очень холодно!")
        }
    }
    func activeDoors (action: DoorState){
        self.doorState = action
        switch action {
        case .open:
            print("Двери открыты, движение невозможно!")
        case.closed:
            print ("Двери закрыты, пристегните ремень безопасности!")
        }
    }
}

// Создадим экземпляр автомобиля FordGT, имплентирующий протокол

class SportCar: CarProtocol {
    
    var manufature: String
    var year: String
    var transmission: Transmission
    var power: Int
    var colour: UIColor
    var modeState: SportMode
    var engineState: EngineState
    var windowsOpen: WindowsState
    var doorState: DoorState
    
    init(manufature: String, year: String, transmission: Transmission, power: Int, colour: UIColor, modeState: SportMode, engineState: EngineState, windowsOpen: WindowsState, doorState: DoorState){
        self.manufature = manufature
        self.year = year
        self.transmission = transmission
        self.power = power
        self.colour = colour
        self.modeState = modeState
        self.engineState = engineState
        self.windowsOpen = windowsOpen
        self.doorState = doorState
    }
    
}
// создадим расширение, выводящие характеристики спортивного автомобиля в консоль
extension SportCar : CustomStringConvertible{
    var description: String{
        return """
        -----------------------------------
        Модель: \(manufature)
        Год выпуска: \(year)
        Мощность: \(power) л/с
        Трансмиссия: \(transmission ==  .automatic ? "Автомат" : "Механика")
        Спортивный режим: \(modeState == .on ? "Включен" : "Выключен")
        Двигатель: \(engineState == .start ? "Включен" : "Выключен")
        Окна: \(windowsOpen == .open ? "Открыты" : "Закрыты")
        Двери: \(doorState == .open ? "Открыты" : "Закрыты")
        """
    }
}

var fordGT = SportCar(manufature: "FordGT", year: "2020", transmission: .automatic, power: 425, colour: .red, modeState: .on, engineState: .start, windowsOpen: .closed, doorState: .closed)

print(fordGT)
fordGT.activeEngine(action: .finish)
fordGT.activeDoors(action: .closed)
fordGT.activeWindows(action: .open)

class WaterTank: CarProtocol {
    
    var manufature: String
    var year: String
    var transmission: Transmission
    var power: Int
    var colour: UIColor
    var washingRoad: RoadWahing
    var engineState: EngineState
    var windowsOpen: WindowsState
    var doorState: DoorState
    let bankVolume = 16
    var carTrunk: Int = 0
    var bankLoad: Int {
        get {
            return carTrunk
        }
        set{
            if carTrunk > bankVolume{
                print("Перегруз, привышен лимит заливаемой воды на \(carTrunk-bankVolume) куб. метров")
            } else {
                carTrunk = newValue + carTrunk
                print("Бочка заполнена  на \(carTrunk) куб. метров, места осталось \(bankVolume-carTrunk) куб. метров")
            }
            
        }
        
    }
    var washing: Int {
        get {
            return carTrunk
        }
        set {
            if newValue > carTrunk {
                carTrunk = 0
                print("Бочка пуста необходимо ехать на гидрант для заправки")
            }else { carTrunk = carTrunk - newValue
                print("Мойка произведена, потрачено \(newValue) куб. метров, бочка заполнена  на \(carTrunk) куб. метров, осталось свободного места \(bankVolume-carTrunk) куб. метров")
            }
        }
    }
    init(manufature: String, year: String, transmission: Transmission, power: Int, colour: UIColor, washingRoad: RoadWahing, engineState: EngineState, windowsOpen: WindowsState, doorState: DoorState){
        self.manufature = manufature
        self.year = year
        self.transmission = transmission
        self.power = power
        self.colour = colour
        self.washingRoad = washingRoad
        self.engineState = engineState
        self.windowsOpen = windowsOpen
        self.doorState = doorState
    }
    func startWashing (action: RoadWahing){
        self.washingRoad = action
        switch action {
        case.start:
            print("Мойка началась, двигайтесь со скоростью 20 км/ч!")
        case.finish:
            print ("Мойка завершена, заправте машину на гидранте  и вернитесь на базу!")
        }
    }
}

extension WaterTank : CustomStringConvertible{
    var description: String{
        return """
        -----------------------------------
        Модель: \(manufature)
        Год выпуска: \(year)
        Мощность: \(power) л/с
        Трансмиссия: \(transmission ==  .automatic ? "Автомат" : "Механика")
        Статус мойки: \(washingRoad == .start ? "Начата" : "Окончена")
        Двигатель: \(engineState == .start ? "Включен" : "Выключен")
        Окна: \(windowsOpen == .open ? "Открыты" : "Закрыты")
        Двери: \(doorState == .open ? "Открыты" : "Закрыты")
        """
    }
}
var kamaz6506 = WaterTank(manufature: "Камаз5620", year: "2011", transmission: .mecanic, power: 500, colour: .black, washingRoad: .start, engineState: .start, windowsOpen: .closed, doorState: .closed)


print(kamaz6506)
kamaz6506.activeEngine(action: .finish)
kamaz6506.activeDoors(action: .closed)
kamaz6506.activeWindows(action: .open)
kamaz6506.bankLoad = 16
kamaz6506.washing = 2
kamaz6506.StartWashing(action: .start)
