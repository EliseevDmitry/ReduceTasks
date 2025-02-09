//
//  main.swift
//  ReduceTasks
//
//  Created by Dmitriy Eliseev on 08.02.2025.
//

import Foundation

/*
 1. На входе строка нужно сконвертить ее в словарь (String -> Dictionary)
 
 "https://oauth.vk.com/blank.html#access_token=533bacf01e11f55b536a565b57531ad114461ae8736d6506a3&expires_in=86400&user_id=8492&state=123456"
 ->
 [
 access_token: 533bacf01e11f55b536a565b57531ad114461ae8736d6506a3,
 expires_in: 86400
 user_id: 8492
 ]
 
 func convert(url: String) -> [String: String] {
 }
 
 
 
 */

func convert(url: String) -> [String: String] {
    let params = url
        .components(separatedBy: "&")
        .map{$0.components(separatedBy: "=")}
        .reduce([String:String]()) {partialResult, param in
            var dict = partialResult
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
        }
    return params
}

let url = "https://oauth.vk.com/blank.html#access_token=533bacf01e11f55b536a565b57531ad114461ae8736d6506a3&expires_in=86400&user_id=8492&state=123456"
let result = convert(url: url)
print(result)



/*
 2. Шопинг в Нью-Йорке. Сколько потратил есть словарь покупок и цен и налог 10% (Dictionary -> Double)
 
 ["socks":5, "shoes":60, "sweater":30] -> 95 * 1.1 = 104.5
 
 func totalPrice(check: Dictionary<String, Int>) -> Double {
 }
 */

func totalPrice(check: Dictionary<String, Int>) -> Double {
    let total = check.values.map({Double($0)}).reduce(0, +) * 1.1
    return total
}


let basket = ["socks" : 5, "shoes" : 60, "sweater" : 30]
let total = totalPrice(check: basket)
print(total)

/*
 3. Найти максимальное и минимальное число в массиве и вывести в кортеже (Array -> Tuple)
 
 [101, 5, 77, 505, 404] -> (5, 505)
 
 func minMax(_ array: [Int]) -> (Int, Int) {
 }
 */

//немного затупил с array[0]
func minMax(_ array: [Int]) -> (Int, Int) {
    let result = array.map({ $0 }).reduce((array[0], Int())) { partialResult, item in
        var result = partialResult
        result.0 = result.0 > item ? item : result.0
        result.1 = result.1 < item ? item : result.1
        return result
    }
    return result
}


let arrayInt = [101, 5, 77, 505, 404]
let resultMinMax = minMax(arrayInt)
print(resultMinMax)

/*
 4. Посчитать количество пололожительных чисел и сумму отрицательных и вывести в кортеже (Array -> Tuple)
 
 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -11, -12, -13, -14, -15] → (10, -65)
 
 func countOfPositivesSumOfNegatives(_ array: [Int]) -> (Int, Int) {
 }
 */

func countOfPositivesSumOfNegatives(_ array: [Int]) -> (Int, Int) {
    let result = array.map({ $0 }).reduce((Int(), Int())) { partialResult, item in
        (
            partialResult.0 + (item >= 0 ? 1 : 0),
            partialResult.1 + (item < 0 ? item : 0)
        )
    }
    return result
}

let arrInt =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -11, -12, -13, -14, -15]
let resultPositivesAndNegatives = countOfPositivesSumOfNegatives(arrInt)
print(resultPositivesAndNegatives)


/*
 
 5. Каждый элемент поделить на порядок в массиве и суммировать (Array -> Int)

 [3,4,6] -> ( 3 / 1 ) + ( 4 / 2 ) + ( 6 / 3 ) = 7


 func add(array: [Int]) -> Int {
 }
 
 */

//func add(array: [Int]) -> Int {
//    let result = array.reduce((Int(), 1)) { partialResult, item in
//        var result = partialResult
//        result.0 += item / result.1
//        result.1 += 1
//        return result
//        
//    }
//    return result.0
//}

//подсмотрена идея извлечения индекса
func add(array: [Int]) -> Int {
    let result = array.enumerated().reduce(0) { partialResult, item in
        return item.element / (item.offset + 1) + partialResult
    }
    return result
}

let intArray = [3,4,6]
let intResult = add(array: intArray)
print(intResult)


/*
 
 6. Посчитать количество nil в значениях словаря (Dictionary -> Int)

 [2: [nil], 3: [nil], 4: [2], 5: [nil], 6: [2, 3, nil]] -> 3

 func searchnils(dict: [Int: Array<Int?>]) -> Int? {
 }
 
 */

//боялся выхода за предел массива - item[0]
func searchnils(dict: [Int: Array<Int?>]) -> Int {
    let result = dict.values.reduce(0) { partialResult, item in
        var result = partialResult
        result += item.count == 1 && item[0] == nil ? 1 : 0
        return result
    }
    return result
}


let dictNil = [2: [nil], 3: [nil], 4: [2], 5: [nil], 6: [2, 3, nil], 8:[]]
let resultDictNil = searchnils(dict: dictNil)
print(resultDictNil)

/*
 7. Написать функцию которая принимает строку и на выходе возвращает количество вхождений
  символов в строке (String -> Dictionary)

 "aaabbbcсaa" → [a:5,b:3,c:2]

 func findContains(_ string: String) -> [Character: Int] {
 }
 */
func findContains(_ string: String) -> [Character: Int] {
    let result = Array(string).reduce([Character: Int]()) { partialResult, char in
        var result = partialResult
        result[char, default: 0] += 1
        return result
    }
    return result
}

let counterString = "aaabbbccaa"
let resultCounterString = findContains(counterString)
print(resultCounterString)

/*
 8. Посчитайте ценность слова (String -> Int)

 A, E, I, O, U, L, N, S, T, R – 1 очко;
 D, G – 2 очка;
 B, C, M, P – 3 очка;
 F, H, V, W, Y – 4 очка;
 K – 5 очков;
 J, X – 8 очков;
 Q, Z – 10 очков.

 APPLE = 1 + 3 + 3 + 1 + 1 = 9

 func score(_ string: String) -> Int {
 }
 */


func score(_ string: String) -> Int {
    //подготовка для расчета ценности слова
    let one = Array("A, E, I, O, U, L, N, S, T, R".components(separatedBy: ", "))
    let two = Array("D, G".components(separatedBy: ", "))
    let three = Array("B, C, M, P".components(separatedBy: ", "))
    let four = Array("F, H, V, W, Y".components(separatedBy: ", "))
    let five: [String] = Array(arrayLiteral: String("K"))
    let six = Array("J, X".components(separatedBy: ", "))
    let seven = Array("Q, Z".components(separatedBy: ", "))
    let arrayChar = [one, two, three, four, five, six, seven]
    let scopeDict = arrayChar.enumerated().reduce([String:Int]()) { partialResult, item in
        var result = partialResult
        
        //думал как через reduce сделать
        for char in item.element {
            result[char, default: 0] = item.offset + 1
        }
        return result
    }
    
    //реализация функции
    let stringArray = Array(string.uppercased())
    return stringArray.reduce(0) { partialResult, item in
        scopeDict[String(item), default: 0] + partialResult
    }
}


let res = score("apple")
print(res)


/*
 
 9. Найти у словаря -> минимальное и максимальное значение

 ["a": 1, "b": 2, "c": 3, "d": 4, "e": 5] -> (1, 5)

 func findminMaxValues(_ dict: Dictionary<String, Int>) -> (Int, Int) {
 }
 
 */

func findminMaxValues(_ dict: Dictionary<String, Int>) -> (Int, Int) {
    guard !dict.isEmpty else { return (0, 0) }
    let result = dict.values.reduce((dict.first!.value, dict.first!.value)) { partialResult, item in
        var result = partialResult
            result.0 = item < result.0 ? item : result.0
            result.1 = item > result.1 ? item : result.1
        return result
    }
    
    return result
}

let minMaxDict = ["a": 1, "b": 2, "c": 3, "d": 4, "e": 5]
let minMaxDictResult = findminMaxValues(minMaxDict)
print(minMaxDictResult)


/*
 10. Разбить строку на N строк

 "abcdef", 2 -> ["abc", "def"]

 func splitNCases(_ string: String, n: Int) -> [String] {
 }
 
 */

func splitNCases(_ string: String, n: Int) -> [String] {
    let result = Array(string).enumerated().reduce(([String](), String())) { partialResult, item in
        var strResult = partialResult
        if (item.offset + 1) % (string.count / n) != 0 {
            strResult.1.append(item.element)
        } else {
            strResult.1.append(item.element)
            strResult.0.append(strResult.1)
            strResult.1.removeAll()
        }
        return strResult
    }
    return result.0
}


let resiltSplit = splitNCases("abcdef", n: 2)
print(resiltSplit)






