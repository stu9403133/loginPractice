//
//  SetBackgroundViewController.swift
//  loginPractice
//
//  Created by stu on 2024/2/7.
//

import UIKit

class SetBackgroundViewController: UIViewController {
    
    
    @IBOutlet weak var choiceBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
 
    var isFirstLoad = true
    
    func updateUI(){
        BackgroundHandler.shared.showBackground(self, isFirstLoad: isFirstLoad)
        isFirstLoad = false
    }
    
    
    @IBAction func changeBG(_ sender: UIButton) {
        BackgroundHandler.shared.updateBackground(self, backgroundNum: sender.tag)
        if let data = try? JSONEncoder().encode(sender.tag){
            print(sender.tag)
            UserDefaultHandler.shared.UserDafaultsSave(key: "background", value: data)
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
