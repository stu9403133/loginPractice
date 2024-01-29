//
//  LoginViewController.swift
//  loginPractice
//
//  Created by stu on 2024/1/27.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var accountText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        // vaildation 第三方套件 swift package
        if accountText.text == "" {
            present(loginAlert(userAlet: "請輸入帳號"), animated: true)
            return
        }else if passwordText.text == "" {
            present(loginAlert(userAlet: "請輸入密碼"), animated: true)
            return
        }else{
            let userInfo = Info(login: accountText.text!, email: "", password: passwordText.text!)
            
            RequestHandler.shared.httpMethod(info: userInfo, status: .createUser) { data in
                
            }
        }
    }
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
