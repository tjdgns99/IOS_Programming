import Cocoa

var str = "Hello, playground"

//후행 클로즈
let names: [String] = ["tiger", "lion", "fox", "bear"]

let reversed0 = names.sorted(by: { (first: String, second: String) -> Bool in return first > second})
print(reversed0)

let reversed1 = names.sorted() {(first: String, second: String) -> Bool in return first > second}
print(reversed1)

let reversed2 = names.sorted() {return $0 > $1}
print(reversed2)

//배열, 많이 쓰지는 않는 듯
let mapped = names.map(){$0.uppercased()}
print("map: ", mapped)

let filtered = names.filter(){
    return $0 > "j"
}
print("filter: ", filtered)

let reduced = names.reduce("jmlee"){
    return $0 + ", " + $1
}
print("reduce: ", reduced)

func myfunc(completion: @escaping() -> Void){
    completion()
    
    DispatchQueue.main.async {
        sleep(3)
        completion()
    }
}

myfunc(){
    print("Hello, EveryBody This is myfunc")
}

var mycompletion: (() -> Void)!
func myfunc2(completion: @escaping() -> Void){ //@escaping 함수가 리턴 한 후에도 호출될 가능성이 있으면 필요
    mycompletion = completion
    
    DispatchQueue.main.async {
        sleep(3)
        mycompletion()
    }
}

myfunc2(){
    print("전역변수 mycompletion 사용: Hello, EveryBody This is myfunc")
}

import UIKit

let session = URLSession(configuration: .default)
let url = URL(string: "http://www.hansung.ac.kr")

let request = URLRequest(url: url!)

let dataTask = session.dataTask(with: url!){
    (data, response, error) in
    if let error = error {
        printed(error)
        return
    }
    if let jsonFate = data{
        if let jsonString = String(data: jsonData, encoding: .utf8){
            print(jsonString)
        }
    }
}
data.Task.resume()


