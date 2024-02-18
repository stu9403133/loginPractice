//
//  AlertHelper.swift
//  loginPractice
//
//  Created by stu on 2024/1/29.
//

import Foundation
import UIKit

func loginAlert(userAlet:String) -> UIAlertController{
    let controller = UIAlertController(title: userAlet, message: nil, preferredStyle: .alert)
    let okAlertAction = UIAlertAction(title: "ok", style: .default)
    controller.addAction(okAlertAction)
    return controller
}
