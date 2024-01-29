//
//  UserDefaultHelper.swift
//  loginPractice
//
//  Created by stu on 2024/1/29.
//

import Foundation


func UserDafaultsSave(key: String, value: Data){
    UserDefaults.standard.set(value, forKey: key)
}

func UserDafaultsRead(key: String) -> Data?{
    guard let data = UserDefaults.standard.data(forKey: key) else{
        return nil
    }
    return data
}
