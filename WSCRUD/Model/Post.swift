//
//  Post.swift
//  WSCRUD
//
//  Created by DISMOV on 04/05/24.
//

import Foundation

struct Post: Codable {
    let id: Int?
    let title: String
    let body: String
    let userId: Int
}
