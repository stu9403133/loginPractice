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
    
    
    var loginUser = Response(){
        didSet{
            if let encodeUser = try? JSONEncoder().encode(loginUser){
                UserDafaultsSave(key: "User", value: encodeUser)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDafaultsRead(key: "User"),
           let encodeData = try? JSONDecoder().decode(Response.self, from: data){
            print("有成功儲存Token在UserDafaults: ",encodeData)
        }
        
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
            
            RequestHandler.shared.httpMethod(info: userInfo, status: .login) { result in
                switch result{
                case .success(let data):
                    if let data = try? JSONDecoder().decode(Response.self, from: data){
                        guard let _ = data.errorCode else {
                            self.loginUser = data
                            
                            print("成功登入", data)
                            DispatchQueue.main.async {
                                self.present(loginAlert(userAlet: "成功登入"), animated: true)
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            self.present(loginAlert(userAlet: data.message!), animated: true)
                        }
                    }
                case .failure(let networkError):
                    switch networkError{
                    case .invaildData:
                    print("invaildData")
                    case .invaildResponse:
                    print("invaildResponse")
                    }
                }
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
