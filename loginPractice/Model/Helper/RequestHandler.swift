//
//  HTTPHelper.swift
//  loginPractice
//
//  Created by stu on 2024/1/27.
//

import Foundation

class RequestHandler{
    static let shared = RequestHandler()
    
    public func sendHttpRequest(info: Info?, status: Status, listOrPost:ListOrPost?, completion: @escaping (Result<Date, NetworkError>)-> Void) {
        URLSession.shared.dataTask(with: createURLRequest(info: info, status: status, listOrPost: listOrPost)) { data, response, error in
            guard let data else {
                completion(.failure(.invaildData))
                print("dataTask Error: ")
                // log response(data)會有一個紀錄檔，紀錄顧客的操作軌跡，是第三方套件
                return
            }
            completion(.success(data))
            if let content = String(data: data, encoding: .utf8){
                print("成功回傳資料", content)
            }
        }.resume()
        print("網路執行中")
    }
    
    private func createURLRequest(info: Info?, status: Status, listOrPost: ListOrPost?) -> URLRequest {
        var finalRequest: URLRequest!
        // log request－顧客個資
        if let url = URL(string: "https://favqs.com/api/\(status.rawValue)") {
            var urlRequest = URLRequest(url: url)
            print("createUser's url: ",url)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Token token=\"1933ce55e106ebf1f42b6389448ceea5\"", forHTTPHeaderField: "Authorization")
            // git ignore
            switch status {
            case .login:
                let session = CreateSession(user: Info(login: info!.login, password: info!.password))
                print("編碼前： ",session)
                let encodeUser = try? JSONEncoder().encode(session)
                print("編碼後： ", encodeUser!)
                urlRequest.httpBody = encodeUser
                urlRequest.httpMethod = "POST"
                
            case .createUser:
                let users = CreateUser(user: Info(login: info!.login, email: info!.email, password: info!.password))
                urlRequest.httpBody = try? JSONEncoder().encode(users)
                urlRequest.httpMethod = "POST"
            case .getQuoteTheDay:
                urlRequest.httpMethod = "GET"
            case .getListOrPost:
                switch listOrPost {
                case .getList:
                    urlRequest.httpMethod = "GET"
                case .postQuote:
                    urlRequest.httpMethod = "POST"
                    let postInfo = QuoteOfTheDayOrPost(quote: QuoteDatail(author: info!.author!, body: info!.body!))
                    urlRequest.httpBody = try? JSONEncoder().encode(postInfo)
                case .none:
                    break
                }
            }
            finalRequest = urlRequest
        }
        return finalRequest
    }

    
    
    

    
    

    
}






