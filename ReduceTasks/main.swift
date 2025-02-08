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
