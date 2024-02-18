//
//  File.swift
//  loginPractice
//
//  Created by stu on 2024/1/30.
//

import Foundation

// Post do not need tags
struct QuoteOfTheDayOrPost: Codable {
    var quote: QuoteDatail
}

struct QuotesList: Codable {
    var quotes: [QuoteDatail]
}

struct QuoteDatail: Codable {
    var tags:[String]?
    var author: String
    var body: String
}


