//
//  TweetMediator.swift
//  HelloWorld
//
//  Created by PC220204 on 2022/09/01.
//

import Foundation

protocol TweetHandlerDelegate {
    func didFetchData(_ tweetHandler: TweetHandler, posts: [Dictionary<String, Any>])
}

protocol TweetMediator {
    func post(content: String)
    func get()
}

enum APIError: Error {
  case network
  case unexpected(String)
}


class TweetHandler: TweetMediator {
    
    var delegate: TweetHandlerDelegate?
    
    private init() {}
    static let shared = TweetHandler()
    
    func post(content: String) {
        let url = URL(string: "http://localhost:50010/post")!
        
        guard let requestBody = try? JSONEncoder().encode(["content": content]) else { return  }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = response as! HTTPURLResponse
                if res.statusCode != 201 {
                    throw APIError.unexpected("投稿に失敗しました")
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    
    }
    
    func get() {
        let url = URL(string: "http://localhost:50010/init_posts")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                let got_posts = object["posts"] as! [Dictionary<String, Any>]
                self.delegate?.didFetchData(self, posts: got_posts)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
