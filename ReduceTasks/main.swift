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
