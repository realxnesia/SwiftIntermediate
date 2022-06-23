import UIKit

var greeting = "Hello, playground"

//MARK: - Reduce Into
// Objektif: find and identify ratings
let ratings = [4, 8.5, 7, 3, 3.2, 3.1, 9, 1, 7]
let reduce_approach1 = ratings.reduce([:]) { (results: [String: Int], rating: Double) in
    var copy = results
    switch rating{
    case 1..<4: copy["verybad", default: 0] += 1
    case 4..<6: copy["ok", default: 0] += 1
    case 6..<8: copy["Good", default: 0] += 1
    case 8..<11: copy["excelent", default: 0] += 1
    default: break
    }
    return copy
}

let reduce_approach2 = ratings.reduce(into: [:]) { (results: inout [String: Int], rating: Double) in
    switch rating{
    case 1..<4: results["verybad", default: 0] += 1
    case 4..<6: results["ok", default: 0] += 1
    case 6..<8: results["Good", default: 0] += 1
    case 8..<11: results["excelent", default: 0] += 1
    default: break
    }
}

let students = ["Dhika", "Aditya", "Are", "Putra"]
let grades = ["9", "7", "5"]

let pair = zip(students, grades)
for zipper in pair{
    print("[*] \(zipper.0) have \(zipper.1)")
}

//MARK: - Function: InOut
struct User{
    var userId: Int? = 0
    let name: String
}

//TODO: V1 -> without inout
func saveUserV1(_ user: User){
    var copyUser = user
    copyUser.userId = 100
}
var newuserV1 = User(name: "DhikaV1")
saveUserV1(newuserV1)

//TODO: V2 -> with inout
func saveUserV2(_ user: inout User){
    user.userId = 100
}
var newUserV2 = User(name: "Dhika V2")
saveUserV2(&newUserV2)

//MARK: Function - Nested Function
struct Pizza {
    let sauce: String
    let toppings: [String]
    let crust: String
}

//TODO: V1 -> Private func hanya dapat diakses di classnya dan semua yg yg ada di kelas PizzaBuilder bisa pakai 'prepareSauce'
class PizzaBuilderV1 {
//    func prepate() -> Pizza{
//        return Pizza
//    }
    
    private func prepareSauce() -> String{
        return "Tomato Sauce"
    }
}

//TODO: V2
class PizzaBuilderV2{
    func prepare() -> Pizza{
        func prepareSauce() -> String {
            return "Tomato Sauce"
        }
        
        func prepareCrust() -> String {
            return "Hand Tossed"
        }
        
        func prepareToppings() -> [String] {
            return ["Chicken", "Mushroom", "Onions"]
        }
        
        let crust = prepareCrust()
        let sauce = prepareSauce()
        let toppings = prepareToppings()
        
        return Pizza(sauce: sauce, toppings: toppings, crust: crust)
    }
}

let pizzaBuilder = PizzaBuilderV2()
let pizza = pizzaBuilder.prepare()

//MARK: - Function -> function as variable, passing function to function
//TODO: V1 -> Simple closure
let hellov1 = {
    print("Hello")
}
//TODO: V2 -> Parsing name
let hellov2: (String) -> () = { name in
    print("Hello \(name)")
}
//TODO: V2.1 -> Parsing name
let helloV3: (String) -> () = {
    print("Hello \($0)")
}
let helloV4: (String) -> () = { _ in
    print("HelloHa")
}

//TODO: V3 -> with parsing variable
let pow : (Int, Int) -> Int = { number, times in
    number * times
}
let resultPow = pow(5, 3)
//TODO: V3.1 -> Without parsing variable
let pow2: (Int, Int) -> Int = {
    $0 * $1
}
let resultPow2 = pow(5, 3)

//TODO: Parsing closure in function
//Don't do this, because the result is always []. because our code need atleast 2 second to load
func getPost() -> [String]{
    var posts: [String] = []
    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
        posts = ["Hello world", "Introduction to closure"]
    }
    return posts
}
print(getPost())
//use this!
func getPost2(completion: @escaping([String]) -> ()) {
    var posts: [String] = []
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        posts = ["Hello world", "Introduction to closure"]
        completion(posts)
    }
}
getPost2 { (post) in
    print(post)
}
