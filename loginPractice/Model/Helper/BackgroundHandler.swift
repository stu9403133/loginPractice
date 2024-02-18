//
//  BackgroundHelper.swift
//  loginPractice
//
//  Created by stu on 2024/2/7.
//

import Foundation
import UIKit

class BackgroundHandler{
    
    static let shared = BackgroundHandler()
    
    var isSetting = false
    
    // 只要有使用到背景頁面的controller就會使用到此函數，因此把解碼寫在裡面，減少程式碼重複性
    func showBackground(_ viewController: UIViewController, isFirstLoad: Bool) {
        // 最一開始使用App 並給予預設背景
        guard let data = UserDefaultHandler.shared.UserDafaultsRead(key: "background") else{
            if let array = Bundle.main.loadNibNamed("BackgroundView", owner: nil),
               let backgroundView = array[0] as? UIView{
                viewController.view.insertSubview(backgroundView, at: 0) //預設背景圖片
            }
            return
        }
        if let num = try? JSONDecoder().decode(Int.self, from: data),
           let array = Bundle.main.loadNibNamed("BackgroundView", owner: nil),
           let backgroundView = array[num] as? UIView {
            if isFirstLoad{
                viewController.view.insertSubview(backgroundView, at: 0)
            } else if isSetting {
                viewController.view.subviews[0].removeFromSuperview()
                viewController.view.insertSubview(backgroundView, at: 0)
            }
        }
    }
    
    //只有設定頁面會使用此函數，用來設定背景
    func updateBackground(_ viewController: UIViewController, backgroundNum: Int){
        if let array = Bundle.main.loadNibNamed("BackgroundView", owner: nil),
           let backgroundView = array[backgroundNum] as? UIView {
            viewController.view.subviews[0].removeFromSuperview()
            viewController.view.insertSubview(backgroundView, at: 0)
            isSetting = true
        }
    }
    
    
    
    
}


