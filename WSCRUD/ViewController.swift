//
//  ViewController.swift
//  WSCRUD
//
//  Created by DISMOV on 04/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    let postService = PostServiceManager.shared
    var newPost = Post(id: nil, title: "Hello", body: "API!!", userId: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: Create
        postService.createPost(post: newPost) { createdPost in
            if let createdPost = createdPost {
                print("created post: ", createdPost)
            } else {
                print("Error: Failed to create post")
            }
        }
        
        //MARK: Update
        let myPost = Post(id: 99, title: "Updated post", body: "New information", userId: 1)
        postService.updatePost(post: myPost) { updatedPost in
            if let updatedPost = updatedPost {
                print("updated post: ", updatedPost)
            } else {
                print("Error: Failed to update post")
            }
        }
        
        //MARK: Delete
        postService.deletePost(id: 5) { status in
            if status == 200 {
                print("Post deleted!!")
            } else {
                print("Error: Failed to delete post")
            }
        }
    }


}

