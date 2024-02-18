//
//  SignUpViewController.swift
//  loginPractice
//
//  Created by stu on 2024/1/27.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var accountText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var userNameText: UITextField!
    
    var createUser = Response(){
        didSet{
            if let encodeUser = try? JSONEncoder().encode(createUser){
                UserDefaultHandler.shared.UserDafaultsSave(key: "User", value: encodeUser)
            }
            
        }
    }
    
    var isFirstLoad = true
    
    override func viewWillAppear(_ animated: Bool) {
        BackgroundHandler.shared.showBackground(self, isFirstLoad: isFirstLoad)
        isFirstLoad = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignUp(_ sender: Any) {
        // vaildation 第三方套件 swift package
        if accountText.text == "" {
            present(loginAlert(userAlet: "請輸入帳號"), animated: true)
            return
        }else if passwordText.text == "" {
            present(loginAlert(userAlet: "請輸入密碼"), animated: true)
            return
        }else if userNameText.text == ""{
            present(loginAlert(userAlet: "請輸入使用者名稱"), animated: true)
        }else{
            let userInfo = Info(login: userNameText.text!, email: accountText.text!, password: passwordText.text!)
            
            RequestHandler.shared.sendHttpRequest(info: userInfo, status: .createUser, listOrPost: nil) { result in
                switch result {
                case .success(let data):
                    if let signUpResponse = try? JSONDecoder().decode(Response.self, from: data){
                        guard let _ = signUpResponse.errorCode else{
                            print(signUpResponse.message!)
                            self.present(loginAlert(userAlet: signUpResponse.message!), animated: true)
                                return
                            }
                        self.createUser = signUpResponse
                        print("signUpResponse: ", signUpResponse)
                        }
                case .failure(let networkError):
                    switch networkError{
                    case .invaildData:
                        print("networkError: ", networkError)
                    case .invaildResponse:
                        print("invaildResponse: ", networkError)
                    
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
