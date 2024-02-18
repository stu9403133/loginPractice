//
//  File.swift
//  loginPractice
//
//  Created by stu on 2024/1/30.
//

import Foundation
// about Request
enum Status:String {
    case login = "session"
    case createUser = "users"
    case getQuoteTheDay = "qotd"
    case getListOrPost = "quotes"
}

enum ListOrPost {
    case getList
    case postQuote
}

// about result
enum Result <Success, Failure> where Failure: Error{
    case success(Data)
    case failure(NetworkError)
}

enum NetworkError: Error{
    case invaildData
    case invaildResponse
}



