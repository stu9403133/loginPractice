//
//  QuoteOfDayViewController.swift
//  loginPractice
//
//  Created by stu on 2024/1/30.
//

import UIKit

class QuoteOfDayViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
   var isFirstLoad = true
   
    override func viewWillAppear(_ animated: Bool) {
        BackgroundHandler.shared.showBackground(self, isFirstLoad: isFirstLoad)
        isFirstLoad = false
    }
    
    override func viewDidLoad() {
//        UserDefaults().removeObject(forKey: "User")
        super.viewDidLoad()
        toUserLogin()
        updateUI()
    }
    
    
    @IBAction func swipeToGetQuote(_ sender: Any) {
        updateUI()
    }
    
    
    
    //about get quote
    func updateUI() {
        
        RequestHandler.shared.sendHttpRequest(info: nil, status: .getQuoteTheDay, listOrPost: nil) { result in
            switch result {
            case .success(let data):
                if let content = try? JSONDecoder().decode(QuoteOfTheDayOrPost.self, from: data){
                    DispatchQueue.main.async {
                        self.quoteLabel.text = content.quote.body
                        self.authorLabel.text = content.quote.author
                    }
                }
            case .failure(let networkError):
                print(networkError)
            }
            
        }
    }
    
    
    // about check login or not
    func toUserLogin() {
        guard UserDefaultHandler.shared.UserDafaultsRead(key: "User") != nil else {
            performSegue(withIdentifier: "LoginViewController", sender: nil)
            return
        }
        print("有token所以不會跳轉頁面")
    }
    
    
    
    
    
}
