//
//  PostServiceManager.swift
//  WSCRUD
//
//  Created by DISMOV on 04/05/24.
//

import Foundation

class PostServiceManager {
    static let shared = PostServiceManager()
    
    init() {
        
    }
    
    func createPost(post: Post, completion: @escaping (Post?) -> Void) {
        guard let url = URL(string: Constants.apiDomain + Constants.postURL) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(post)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let createdPost = try? JSONDecoder().decode(Post.self, from: data) {
                        completion(createdPost)
                    }
                } else if let error = error {
                    print("Error: ", error)
                    completion(nil)
                }
            }
            task.resume()
        } catch let error {
            print("Error: ", error)
            completion(nil)
        }
    }
    
    func updatePost(post: Post, completion: @escaping (Post?) -> Void) {
        guard let url = URL(string: Constants.apiDomain + Constants.postURL + String(post.id!)) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(post)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let updatedPost = try? JSONDecoder().decode(Post.self, from: data) {
                        completion(updatedPost)
                    }
                } else if let error = error {
                    print("Error: ", error)
                    completion(nil)
                }
            }
            task.resume()
        } catch let error {
            print("Error: ", error)
            completion(nil)
        }
    }
    
    //MARK: Delete Method
        func deletePost(id: Int, completion: @escaping (Int) -> Void ) {
            let url = URL(string: Constants.apiDomain+Constants.postURL+String(id))!
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completion(response.statusCode)
                }
                else if let error = error {
                    print("Error: ", error)
                    completion(0)
                }
            }
            task.resume()
        }
}
