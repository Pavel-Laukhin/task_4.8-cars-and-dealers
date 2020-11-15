/*:
 # Задача 1 (основная)
 ВЫ - главный архитектор в команде разработчиков. Ваша задача - разработать программное обеспечение (ПО) для дилерских центров по продаже автомобилей. Ваша цель - создать гибкое ПО. Что это значит? Ваше ПО должно подходить для любой марки авто, а также оно должно быть расширяемым и масштабируемым в дальнейшем, чтобы ваша компания могла выпускать обновления. Задача разделена на 4 части, в каждой из которых нужно самостоятельно подумать, какой тип данных передать каждому свойству для комфортной работы, а также, по-необходимости, добавить вспомогательные методы.
 */
import Foundation

protocol Car {
    
    var model: Brands { get }
    var color: Colors { get }
    var buildDate: Date { get }
    var price: Int { get set }
    
    ///Дополнительное оборудование (тонировка, сингнализация, спортивные диски)
    var accessories: Set<Accessories>? { get set }
    
    ///Сделана ли предпродажная подготовка. Обычно ее делают в дилерских центрах перед постановкой машины в салон
    var isServiced: Bool { get set }
    
}

protocol Dealership {
        
    ///Название дилерского цетра (назвать по марке машины для упрощения)
    var name: Brands { get }
    
    ///Максимальная вместимость автосалона по кол-ву машин
    var showroomCapacity: Int { get }
    
    ///Машины, находящиеся на парковке склада. Представим, что парковка не имеет лимита по количеству машин.
    var stockCars: [Car] { get set }
    
    ///Машины, находящиеся в автосалоне
    var showroomCars: [Car] { get set }
    
    ///Cписок всех машин в наличии
    var cars: [Car] { get set }
    
    ///Метод предлагает клиенту купить доп. оборудование. Принимает массив акксесуаров в качестве параметра. Метод должен выводить в консоль информацию о машине и выполненном действии с ней.
    func offerAccesories(_ accessories: [Accessories])
    
    ///Метод отправляет машину на предпродажную подготовку. Принимает машину в качестве параметра. Метод должен выводить в консоль информацию о машине и выполненном действии с ней.
    func presaleService(_ car: inout Car)
    
    ///Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку. Принимает машину в качестве параметра. Метод должен выводить в консоль информацию о машине и выполненном действии с ней.
    func addToShowroom(_ car: Car)
    
    ///Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка. Также, если у машины отсутсвует доп. оборудование, нужно предложить клиенту его купить. (давайте предстваим, что клиент всегда соглашается и покупает :) ) Принимает машину в качестве параметра. Метод должен выводить в консоль информацию о машине и выполненном действии с ней.
    func sellCar(_ car: Car)
    
    ///Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада. Не принимает и не возвращает параметры. Метод должен выводить в консоль информацию о машине и выполненном действии с ней.
    func orderCar()

}

// Добавим также наборы характеристик авто:

///Набор аксессуаров для авто:
enum Accessories: String, CaseIterable {
    case footPad = "Foot pad"
    case chordPlatedParts = "Сhord-plated parts"
    case neonLights = "Neon lights"
    case enlargedWheels = "Enlarged wheels"
    case firstAidKit = "First Aid Kit"
    case fireStopper = "Extinguisher"
}

///Варианты расцветок авто:
enum Colors: Int, CaseIterable {
    case white, red, black
}
/*:
 ## Часть 3.
 Настало время добавить классы и структуры, реализующие созданные ранее протоколы.

 ### Алгоритм выполнения
 1. Используя структуры, создайте несколько машин разных марок (например BMW, Honda, Audi, Lexus, Volvo). Все они должны реализовать протокол 'Car'
 1. Используя классы, создайте пять различных дилерских центров (например BMW, Honda, Audi, Lexus, Volvo). Все они должны реализовать протокол 'Dealership'. Каждому дилерскому центру добавьте машин на парковку и в автосалон (используйте те машины, которые создали ранее).
 1. Создайте массив, положите в него созданные дилерские центры. Пройдитесь по нему циклом и выведите в консоль слоган для каждого дилеского центра (слоган можно загуглить).
 
 Обратите внимание! Используйте конструкцию приведения типа данных для решения этой задачи.
 */
///Марки машин:
enum Brands: String {
    case BMW, Honda, Audi, Lexus, Volvo
}

struct CarStruct: Car {
    
    var model: Brands
    
    var color: Colors
    
    var buildDate: Date
    
    var price: Int
    
    var accessories: Set<Accessories>?
    
    var isServiced: Bool
    
}

class Dealer: Dealership {
    
    var name: Brands
    
    var showroomCapacity: Int
    
    var stockCars: [Car]
    
    var showroomCars: [Car]
    
    var cars: [Car]
    
    var accesories: Set<Accessories>
    
    init(name: Brands, showroomCapacity: Int, stockCars: [Car], showroomCars: [Car], accesories: Set<Accessories>) {
        self.name = name
        self.showroomCapacity = showroomCapacity
        self.stockCars = stockCars
        self.showroomCars = showroomCars
        cars = stockCars + showroomCars
        self.accesories = accesories
    }
    
    func offerAccesories(_ accessories: [Accessories]) {
        print("Предлагаем Вам следующие аксессуары к вашему авто:\n")
        for item in accessories {
            print("\(item)")
        }
        print("\n")
    }
    
    func presaleService(_ car: inout Car) {
        print("Автомобиль \(car.model) отправлен на предпродажную подготовку.\n")
        car.isServiced = true
        print("Автомобиль \(car.model) прошел предпродажную подготовку.\n")
    }
    
    func addToShowroom(_ car: Car) {
        
        // Ищем индекс машины на парковке:
        if let index = stockCars.firstIndex(where: { (Car) -> Bool in
            return Car.model == car.model ? true : false
        }) {
            var findedCar = stockCars.remove(at: index) //убираем машину с парковки
            print("Автомобиль убран с парковки")
            presaleService(&findedCar) //делаем предпродажную подготовку
            showroomCars.append(findedCar) //добавляем машину в шоу-рум
            print("Автомобиль доставлен в шоу-рум")
        }
    }
    
    func sellCar(_ car: Car) {
        
        // Ищем индекс машины в шоу-руме:
        if let index = showroomCars.firstIndex(where: { $0.model == car.model } ) {
            var findedCar = showroomCars.remove(at: index)
            
            //Проверяем, есть ли аксессуары у автомобиля. Если нет, то предлагаем их и добавляем:
            if findedCar.accessories?.isEmpty ?? false {
                offerAccesories(Array(accesories))
                findedCar.accessories = accesories
                print("Аксессуары добавлены")
            }
            
            //Проверяем, была ли предпродажная подготовка. Если нет, то делаем:
            if !findedCar.isServiced {
                presaleService(&findedCar) //Делаем предпродажную подготовку
            }
            print("Автомобиль продан")
        }
        
    }
    
    func orderCar() {
        
        //Создадим массив аксессуаров для новой машины:
        var randomAccesoriesForNewCar: Set<Accessories>?
        
        //Заполним массив аксессуаров рандомным количеством аксессуаров
        for _ in 0...Int.random(in: 0...accesories.count) {
            randomAccesoriesForNewCar?.insert(accesories.randomElement()!)
        }
        
        let randomColorForNewCar = Colors.init(rawValue: Int.random(in: 0..<Colors.allCases.count))!
        
        let newCar = CarStruct(
            model: name, //Бренд машины совпадает с брендом диллера
            color: randomColorForNewCar,
            buildDate: Date(timeIntervalSinceNow: 0),
            price: Int.random(in: 10000...50000)/1000*1000, //Рандомный прайс в диапазоне с шагом в 1000
            accessories: randomAccesoriesForNewCar,
            isServiced: Bool.random()
        )
        print("Получили новый автомобиль с производства \n")
        stockCars.append(newCar)
        print("Доставили новый автомобиль на склад")
    }
    
}

class BMW: Dealer {}

class Audi: Dealer {}

class Honda: Dealer {}


// Создадим несколько дат:
let formatter = DateFormatter()
formatter.dateFormat = "yyyy/MM"
let date1 = formatter.date(from: "2020/03")!
let date2 = formatter.date(from: "2020/01")!
let date3 = formatter.date(from: "2019/12")!
let date4 = formatter.date(from: "2019/10")!
let date5 = formatter.date(from: "2019/09")!


//Создаем несколько машин:
var bmw1 = CarStruct(
    model: .BMW,
    color: .white,
    buildDate: date1,
    price: 15_000,
    accessories: nil,
    isServiced: false)
let bmw2 = CarStruct(
    model: .BMW,
    color: .red,
    buildDate: date2,
    price: 50_000,
    accessories: [
        .chordPlatedParts,
        .footPad,
        .enlargedWheels,
        .neonLights],
    isServiced: true)
let bmw3 = CarStruct(
    model: .BMW,
    color: .black,
    buildDate: date3,
    price: 20_000,
    accessories: [.footPad],
    isServiced: false)
let bmw4 = CarStruct(
    model: .BMW,
    color: .black,
    buildDate: date4,
    price: 25000,
    accessories: [.footPad, .enlargedWheels],
    isServiced: false)
let bmw5 = CarStruct(
    model: .BMW,
    color: .white,
    buildDate: date5,
    price: 25000,
    accessories: [.enlargedWheels],
    isServiced: false)

let audi1 = CarStruct(
    model: .Audi,
    color: .white,
    buildDate: date1,
    price: 25000,
    accessories: nil,
    isServiced: false)
let audi2 = CarStruct(
    model: .Audi,
    color: .white,
    buildDate: date2,
    price: 30000,
    accessories: [.enlargedWheels],
    isServiced: false)
let audi3 = CarStruct(
    model: .Audi,
    color: .black,
    buildDate: date3,
    price: 20000,
    accessories: [.footPad],
    isServiced: false)
let audi4 = CarStruct(
    model: .Audi,
    color: .black,
    buildDate: date4,
    price: 25000,
    accessories: [.footPad, .enlargedWheels],
    isServiced: false)
let audi5 = CarStruct(
    model: .Audi,
    color: .white,
    buildDate: date5,
    price: 25000,
    accessories: [.enlargedWheels],
    isServiced: false)

let honda1 = CarStruct(
    model: .Honda,
    color: .white,
    buildDate: date1,
    price: 15000,
    accessories: nil,
    isServiced: false)
let honda2 = CarStruct(
    model: .Honda,
    color: .red,
    buildDate: date2,
    price: 50000,
    accessories: [.chordPlatedParts, .footPad, .enlargedWheels, .neonLights],
    isServiced: true)
let honda3 = CarStruct(
    model: .Honda,
    color: .black,
    buildDate: date3,
    price: 20000,
    accessories: [.footPad],
    isServiced: false)
let honda4 = CarStruct(
    model: .Honda,
    color: .black,
    buildDate: date4,
    price: 25000,
    accessories: [.footPad, .enlargedWheels],
    isServiced: false)
let honda5 = CarStruct(
    model: .Honda,
    color: .white,
    buildDate: date5,
    price: 25000,
    accessories: [.enlargedWheels],
    isServiced: false)

//Создадим диллерские центры:
let bmwShop = BMW(
    name: .BMW,
    showroomCapacity: 10,
    stockCars: [bmw1, bmw2, bmw3],
    showroomCars: [bmw4, bmw5],
    accesories: [.chordPlatedParts, .enlargedWheels, .footPad, .neonLights]
)
let audiShop = Audi(
    name: .Audi,
    showroomCapacity: 10,
    stockCars: [audi1, audi2, audi3],
    showroomCars: [audi4, audi5],
    accesories: [.chordPlatedParts, .enlargedWheels, .footPad, .neonLights]
)
let hondaShop = Honda(
    name: .Honda,
    showroomCapacity: 10,
    stockCars: [honda1, honda2, honda3],
    showroomCars: [honda4, honda5],
    accesories: [.chordPlatedParts, .enlargedWheels, .footPad, .neonLights]
)

//Создадим массив диллерских центов:
let dealershipArray = [bmwShop, audiShop, hondaShop] as [Any]

//Напечатаем слоганы, исплользуя конструкцию приведения типов данных:
for dealership in dealershipArray {
    if dealership is BMW {
        print("BMW. С удовольствием за рулем.")
    }
    if dealership is Audi {
        print("Audi. Превосходство высоких технологий.")
    }
    if dealership is Honda {
        print("Honda. The power of dreams.")
    }
}
/*:
 ## Часть 4. Работа с расширениями.
 Нам нужно добавить спецпредложение для "прошлогодних" машин.

### Алгоритм выполнения
 1. Создайте протокол SpecialOffer.
 1. Добавьте методы:
    * 'addEmergencyPack()': не принимает никаких параметров. Метод добавляет аптечку и огнетушитель к доп. оборудованию машины.
    * 'makeSpecialOffer()': не принимает никаких параметров. Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего, нужно сделать скидку 15%, а также добавить аптеку и огнетушитель.
 1. Используя расширение, реализуйте протокол 'SpecialOffer' для любых трех дилерских центров.
 1. Проверьте все машины в дилерском центре (склад + автосалон), возможно они нуждаются в специальном предложении. Если есть машины со скидкой на складе, нужно перегнать их в автосалон.
 */
// Создаем протокол:
protocol SpecialOffer {
    
    ///Метод добавляет аптечку и огнетушитель к доп. оборудованию машины. Не принимает никаких параметров.
    mutating func addEmergencyPack()
    
    ///Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего, нужно сделать скидку 15%, а также добавить аптеку и огнетушитель. Не принимает никаких параметров.
    func makeSpecialOffer()
}

extension SpecialOffer {
    
    ///Метод добавляет аптечку и огнетушитель к доп. оборудованию машины. Не принимает никаких параметров.
    mutating func addEmergencyPack() {
        if self is Car {
            guard var tempCar = self as? Car else { return }
            if tempCar.accessories != nil {
                tempCar.accessories!.insert(.firstAidKit)
                tempCar.accessories!.insert(.fireStopper)
                self = tempCar as! Self
            } else {
                tempCar.accessories = [.firstAidKit, .fireStopper]
                self = tempCar as! Self
            }
        }
    }
    
    ///Метод, который ничего не делает. Нужен для того, чтобы реализация данного метода была необязательной у протокола SpecialOffer.
    func makeSpecialOffer() {
        print("Метод по умолчанию не делает ничего")
    }
    
}

// Добавляем стуктуре автомобиля соответствие протоколу:
extension CarStruct: SpecialOffer {}

// Пример работы метода протокола у экземпляра автомобиля:
bmw1.accessories // nil
bmw1.addEmergencyPack()
bmw1.accessories // {firstAidKit, fireStopper}

//Добаляем всем дилерским центрам (родительскому классу):
extension Dealer: SpecialOffer {

    func addEmergencyPack() {
        // Реализовываем метод для дилера (для всех машин дилера)
        addEmergencyPackUniversal(&showroomCars)
        addEmergencyPackUniversal(&stockCars)
    }

    func makeSpecialOffer() {
        // Реализовываем метод для дилера (для всех машин дилера)
        addSpecialOfferAndRelocate(from: &self.stockCars, to: &showroomCars, discount: 0.15)
    }
    
    //Создаем универсальные функции добавления скидок и аксессуаров, перемещения между складами:
    
    ///Универсальная функция, которая принимает массив из машин, снижает цену всем машинам старше текущего года и добавляет аптечку и огнетушитель к их аксессуарам. Используется в расширениях для диллерских центов.
    private func addSpecialOfferUniversal(_ cars: inout [Car], discount: Double) {
        var tempArray: [Car] = []
        
        // get the current date and time
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [.year]
        
        cars.forEach {
            var tempCar = $0
            guard
                let buildYear = userCalendar.dateComponents(requestedComponents, from: tempCar.buildDate).year,
                let currentYear = userCalendar.dateComponents(requestedComponents, from: currentDateTime).year
                else { return }
            
            //Проверяем, что год у данной машины меньше текущего года. Если так, то проводим манипуляции:
            if buildYear < currentYear {
                
                //Пересчитываем прайс у этого авто:
                let newPrice = Int(Double(tempCar.price) * (1 - discount))
                tempCar.price = newPrice
                
                //Добавляем аптечку и огнетушитель:
                if tempCar.accessories != nil {
                    tempCar.accessories!.insert(.firstAidKit)
                    tempCar.accessories!.insert(.fireStopper)
                } else {
                    tempCar.accessories = [.firstAidKit, .fireStopper]
                }
            }
            tempArray.append(tempCar)
        }
        cars = tempArray
    }

    ///Универсальная функция, которая принимает массив из машин, снижает цену всем машинам старше текущего года и добавляет аптечку и огнетушитель к их аксессуарам. И перемещает из одного склада на другой. Используется в расширениях для диллерских центов.
    private func addSpecialOfferAndRelocate(from cars: inout [Car], to destination: inout [Car], discount: Double) {
        addSpecialOfferUniversal(&destination, discount: discount)

        var tempArrayOfUntouched: [Car] = []
        
        // get the current date and time
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [.year]
        
        cars.forEach {
            var tempCar = $0
            guard
                let buildYear = userCalendar.dateComponents(requestedComponents, from: tempCar.buildDate).year,
                let currentYear = userCalendar.dateComponents(requestedComponents, from: currentDateTime).year
                else { return }
            
            //Проверяем, что год у данной машины меньше текущего года. Если так, то проводим манипуляции:
            if buildYear < currentYear {
                
                //Пересчитываем прайс у этого авто:
                let newPrice = Int(Double(tempCar.price) * (1 - discount))
                tempCar.price = newPrice
                
                //Добавляем аптечку и огнетушитель:
                if tempCar.accessories != nil {
                    tempCar.accessories!.insert(.firstAidKit)
                    tempCar.accessories!.insert(.fireStopper)
                } else {
                    tempCar.accessories = [.firstAidKit, .fireStopper]
                }
                
                //Перемещаем из одного склада в другой. Делаем временный склад
                destination.append(tempCar)
            } else {
                tempArrayOfUntouched.append(tempCar)
            }
        }
        cars = tempArrayOfUntouched
    }
    
    ///Универсальная функция, которая принимает массив из машин и добавляет аптечку и огнетушитель к их аксессуарам. Используется в расширениях для диллерских центов.
    private func addEmergencyPackUniversal(_ cars: inout [Car]) {
        var tempArray: [Car] = []
        var tempCar: Car?
        cars.forEach {
            tempCar = $0
            if tempCar?.accessories != nil {
                tempCar?.accessories!.insert(.firstAidKit)
                tempCar?.accessories!.insert(.fireStopper)
            } else {
                tempCar?.accessories = [.firstAidKit, .fireStopper]
            }
            tempArray.append(tempCar!)
        }
        cars = tempArray
    }
    
}

//Делаем спешл оффер у наших дилеров:

bmwShop.showroomCars.count // Для дебага. Должно быть 2 штуки (номер 4 и 5 от 2019 года)

bmwShop.makeSpecialOffer()
audiShop.makeSpecialOffer()
hondaShop.makeSpecialOffer()

bmwShop.showroomCars.count // Для дебага. Должно стать 3 штуки (номер 4, 5 и 3 от 2019 года)


//// Вопрос от студентки:
//class ExampleDealer {
//    
//    var name: Dealership
//    
//    var showroomCapacity: Int
//    
//    var stockCars: [Car]
//    
//    var showroomCars: [Car]
//    
//    var _cars: [Car] = []
//    
//    var cars: [Car] {
//        get {
//            return _cars
//        }
//        set {
//            self._cars = newValue
//        }
//    }
//    
//    var accesories: Set<Accessories>
//    
//    init(name: Dealership, showroomCapacity: Int, stockCars: [Car], showroomCars: [Car], accesories: Set<Accessories>) {
//        self.name = name
//        self.showroomCapacity = showroomCapacity
//        self.stockCars = stockCars
//        self.showroomCars = showroomCars
//        _cars = stockCars + showroomCars
//        self.accesories = accesories
//    }
//    
//    func offerAccesories(_ accessories: [Accessories]) {
//    
//    }
//    
//    func presaleService(_ car: inout Car) {
//    
//    }
//    
//    func addToShowroom(_ car: Car) {
//    
//    }
//    
//    func sellCar(_ car: Car) {
//    
//    }
//    
//    func sellCar(with car: inout Car) {
//        if car.isServiced {
//            if let myCars = cars as? [Audi], let myCar = car as? Audi {
//                if let index = myCars.firstIndex(of: myCar) {
//                    
//                }
//            }
//        }
//    }
//    
//    func orderCar() {
//    
//    }
//    
//    
//}



/*:
 Задача: сделать так, чтобы можно было напечатать описание содержимого складов у наших дилеров.
 */
// Решение 1.
extension Array where Element == Car {
    var description: String {
        var string: String = "\nРешение 1: " + "\(type(of: self)), \(self.count) items:\n"
        for item in self {
            string += item.model.rawValue + "\n"
        }
        return string
    }
}

// Решение 2.
extension Array where Element == Car {
    var description1: String {
        return "\nРешение 2: " + "\(type(of: self)), \(self.count) items:\n" + self.map({"\($0.model.rawValue)"}).joined(separator: "\n")
    }
}

// Решение 3.
extension String {
    init(describing instance: Array<Car>) {
        let description = "\nРешение 3: " + "\(type(of: instance)), \(instance.count) items:\n" + instance.map({"\($0.model.rawValue)"}).joined(separator: "\n")
        self.init("\(description)")
    }
}

// Проверяем, как работают наши решения:
print(bmwShop.showroomCars.description)
print(bmwShop.showroomCars.description1)
print(String(describing: bmwShop.showroomCars))


extension Dealer: CustomStringConvertible {
    public var description: String {
        var description: String = "\nDealer of \(type(of: self)):\n"
        description += "  \(self.showroomCars.count) cars in showroom:\n"
        description += self.showroomCars.map({"    \($0.model.rawValue), price: \($0.price)"}).joined(separator: "\n") + "\n"
        description += "  \(self.stockCars.count) cars in stock:\n"
        description += self.stockCars.map({"    \($0.model.rawValue), price: \($0.price)"}).joined(separator: "\n") + "\n"
        description += "  Available accesories:\n"
        for (index, item) in self.accesories.enumerated() {
            description += "    \(index + 1). " + item.rawValue + "\n"
        }
        return description
    }
}

print(bmwShop)
