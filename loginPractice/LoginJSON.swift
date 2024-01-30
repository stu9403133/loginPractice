//
//  File.swift
//  loginPractice
//
//  Created by stu on 2024/1/27.
//

import Foundation

// To create a new user
struct CreateUser: Codable{
    var user: Info
}

// can login by username or email
struct CreateSession: Codable{
    var user:Info
}

struct Info:Codable{
    var login: String
    var email: String?
    var password: String
}

// for decode response JSON contenttype
struct Response: Codable{
    var usertoken: String?
    var login: String?
    var email: String?
    var errorCode: Int?
    var message: String?
    
    enum CodingKeys: String, CodingKey{
        case usertoken = "User-Token"
        case login
        case email
        case errorCode = "error_code"
        case message
    }
}


