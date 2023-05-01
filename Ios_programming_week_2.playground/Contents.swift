import Cocoa

var str = "Hello, playground"
print(str)

var myVariable = 42     //변수, var
myVariable += 42
let yourVariable = 42   //상수, let
//yourVariable += 42    //상수, 변경 불가 Error
//타입을 명사적욿 지정할 수도 안할수도 있음, 지정하지 않으면 rvalue 타입으로 추론하여 지정
let inplicitInteger = 70
let implicitDouble = 70.5
let explicitDouble: Double = 70
//float 형으로 타입을 지정하여 4룰 할당
let exersize: Float = 4
print(exersize)

//형 변환, 좌우 타입이 다를 경우 형 변환 필요
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
print(widthLabel)
//문자열 안에 변수 값 적용
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit"
//\()를 이용하여 문저열 안에 실수형 계산을 포함하도록 해보고, 인사말 안에 누군가의 이름을 넣어보자
let name = "Sunghoon"
let f1 = 24.5
let f2 = 0.5
let introduce = "My name is \(name) and I'm \(f1 + f2) years old"
print(introduce)

//배열, 딕셔너리, 배열과 딕셔너리는 대괄호[]를 이용해 만듬
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
var occupation = ["Malcolm":"Captian", "Kaylee":"Mechanic", ]
occupation["Jayne"] = "Public Relations"
//빈 배열, 딕셔너리
let emptyArray: [String] = []   //let emthyArray = [String]()
let emptyDictionary: [String: Float] = [:]  //let emptyDictionary = [String: Float]()

//옵셔널 변수, nil 값을 저장할 수 있는 변수, var variableName: type?
//옵셔널 변수가 아닌 경우는 무조건 값이 저장되어 있어야 함
var optionalString: String? = "Hello"   //옵셔넣 변수
optionalString == nil                   //false
var optionalName: String? = "John Appleseed" //옵셔널 변수
var greeting = "Hello!"                 //논 옵셔널 변수
if let name = optionalName {
    greeting = "Hello, \(name)"
}
print(greeting)
//optionalName의 값을 nil로 변경, 어떤 greeting의 값을 받을 수 있는가? optionalName에 할당된 값이 nil일 때 다른 값을 greeting에 할당하도록 else 절을 추가(옵셔널 바인딩: 옵셔널 변수에 nil이 들어가 있지 않으며 그 값을 추출하여 저장)
optionalName = nil
if let name = optionalName {
    greeting = "Hello, \(name)"
}else {
    greeting = "Name is unknowned"
}
print(greeting)

//흐름제어, 조건문: if와 switch, 반복문: for-in, for, while, repeat-while
let individualScore = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScore {
    if(score > 50){
        teamScore += 3
    }else{
        teamScore += 1
    }
}
print(teamScore)

//Switch문, default가 있어야 함
let vegetable = "red pepper"
switch vegetable{
case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):
    let vegetableComment = "Is it a spicy \(x)?"
default:
    let vegetableComment = "Everything tastes good in soup."
}

//For-in, 각각 키/값 쌍으로 사용하는 딕셔너리 요소들을 반복 처리
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    " Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

//for ..< OR for...
var firstForLoop = 0
for i in 1..<4 {
            firstForLoop += i     // 1, 2, 3
}
firstForLoop
var secondLoop = 0
for _ in 1...4{
            secondLoop += 1
}
secondLoop

//Function, func를 사용 함수 선언, 함수 호출 시 함수 이름과 괄호 안에 인자들 삽입 가능, 매개변수 이름과 분리 '->'사용 타입 이름을 표기하면 함수 반환 값의 타입을 지정
func greet(name: String, day: String) -> String
{
    return "Hello \(name), today is \(day)."
}
print(greet(name: "Bob", day: "Tuesday"))

//튜플로 반환, 일반적으로 배열과 동일하나 변경 불가능
func getGasPrices() -> (Double, Double, Double){
    return (3.59, 3.69, 3.79)
}
getGasPrices()
//배열 인자, 배열을 이용해서 여러개의 값을 함수의 인자로 받을 수도 있음
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers{
        sum += number
    }
    return sum
}
sumOf()
sumOf(numbers: 42, 597, 12)
//평균값을 계산하는 함수
func avgOf(numbers: Int...) -> Int{
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum/numbers.count
}
print(avgOf(numbers: 42, 597, 12))
//중첩 함수, 함수는 중첩해서 사용 가능
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

//함수도 최상위 타입(First class type), 어떤 함수가 다른 함수를 반환 값 형태로 반환할 수 있다는 것을 의미
//최상위 타입이란, 다른 객체들에 일반적으로 적용 가능한 연산을 모두 지원하는 객체
//보통 함수에 매개변수로 넘기기, 수정하기, 변수에 대입하기와 같은 연산을 지원할 때 최상위 타입 객체
func makeIncremeter() -> (Int) -> Int {
    func addOne(number: Int) -> Int{
        return 1 + number
    }
    return addOne
}
var increment = makeIncremeter()
print(increment(7))

//함수도 최상위 타입(First class type), 함수도 매개변수로 받을 수 있음
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
            for item in list {
                        if condition(item) {
                                    return true
                            }
                }
            return false
}
 
func lessThanTen(number: Int) -> Bool {
            return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list:  numbers, condition: lessThanTen)

//클로저, 이름없는 함수: {}, 실제로 함수는 클로저의 특별한 예, 중괄호로 묶어서 이름을 지정하지 않고도 클로저를 사용, in을 사용해 인자와 반환값을 분리해 사용
let numbers1 = [10, 21, 30]
let y = numbers1.map(
    {
                    (number: Int) -> Int in // (매개변수) -> 반환값
      
                    let result = 3 * number
                    return result
            }
)
y      // [30, 60, 90]

//클로저의 간결화, 추론될 수 있는 모든 것은 생략 가능

//매개변수 번호
let numbers2 = [10, 20, 30]
var y1 = numbers2.map() {3 * $0}    //number2.map({2 * $0})
print(y1)

//Class, 클래스를 만들기 위해서는 클래스 이름과 함께 class 키워드 사용, 메서드와 함수도 선언, new 키워드 없음
class Shape {
    var numberOfSides = 0
      
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
var shape = Shape() // 생성자 호출
shape.numberOfSides = 7
var  shapeDescription = shape.simpleDescription()

//초기화자 사용(생성자), init 키워드 사용
class NamedShape {
    var numberOfSides: Int = 0 // nonoptional이나 초기화를 함
    var name: String // nonoptional이나 초기화를 하지 않음
    init(name: String) {
        self.name = name // 여기서 반드시 초기화 하여야 함, nonoptional
    }
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
//파괴자, deinit 키워드 사용

//override, 하위 클래스에서 상위 클래스에서 구현괸 메서드를 오버라이드하려면 override키워드를 이용해 표시해줘야함
class Square: NamedShape {
    var sideLength: Double
 
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
 
    func area() ->  Double {
        return sideLength * sideLength
    }
 
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()
//   실습 : NamedShape 클래스의 또 다른 하위 클래스인 Circle 을 만들어보자 . 이 클래스는 이니셜 라이저를 통해   radius 와 name 을 인자로 받는다 . Circle 클래스 안에 area, simpleDescription 함수를 구현해보자 .

//getter/setter, 저장되어 있는 간단한 속성 외에도 속성은 getter와 setter를 가질 수 있음
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    var perimeter: Double {
        get {
                return 3.0 * sideLength
        }
        set {
                sideLength = newValue / 3.0
        }
    }
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter // call get
triangle.perimeter = 9.9 // call set
triangle.sideLength

//열거형, enum 키워드를 사용하면 열거형을 생성 가능, 클래스나 모든 알려진 타입들의 경우 열거형에 메서드를 포함할 수 있음
enum Rank: Int {
    case Ace = 1   // 실제값
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten //각각 따로 쓰도 된다
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue
//   실험 :  두개의 Rank 값의 원본 값을 비교하는 함수를 만들어보자 .

//실습1. for OR while반복문을 이용 100까지 더하는 프로그램을 하라
func sum100() -> Int{
    var sum = 0
    for number in 1...100{
        sum += number
    }
    return sum
}
print(sum100())

//실습2. random 함수를 이용하여 100개의 배열을 만들어 최소, 최대값을 찾는 프로그램을 하라
var arr: [Int] = []
for i in 0..<100{
    arr.append(Int.random(in: 1...1000))
}
func find(arr: [Int]) -> (Int, Int){
    var min = arr[0]
    var max = arr[0]
    for number in arr{
        if(min > number){
            min = number
        }
        
        if(max < number){
            max = number
        }
    }
    return (min, max)
}
print(find(arr: arr))

//실습3. random 함수를 이용하여 100개의 배열을 만들어 후행 클로저를 이용하여 정렬하는 프로그램
let y3 = arr.sort(){$0 > $1}


















