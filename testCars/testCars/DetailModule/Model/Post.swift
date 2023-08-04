//
//  Post.swift
//  testCars
//
//  Created by Дмитрий Цветков on 04.08.2023.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let posts: [PostElement]?
    let user: User?
}

// MARK: - PostElement
struct PostElement: Codable {
    let id: Int?
    let text: String?
    let likeCount: Int?
    let createdAt: String?
    let commentCount: Int?
    let img: String?
    let author: User?

    enum CodingKeys: String, CodingKey {
        case id, text
        case likeCount = "like_count"
        case createdAt = "created_at"
        case commentCount = "comment_count"
        case img, author
    }
    
    // MARK: - User
    struct User: Codable {
        let id: Int?
        let username: String?
        let avatar: Avatar?
        let autoCount: Int?
        let mainAutoName: String?

        enum CodingKeys: String, CodingKey {
            case id, username, avatar
            case autoCount = "auto_count"
            case mainAutoName = "main_auto_name"
        }
    }
    
    // MARK: - Avatar
    struct Avatar: Codable {
        let path: String?
        let url: String?
    }
}


