//
//  ArticleInfo.swift
//  BlogAppJ2T
//
//  Created by Vaibhav jain on 11/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

// MARK: - ArticleInfo
public struct ArticleInfo: Codable {
    public let id, createdAt, content: String?
    public let comments, likes: Int?
    public let media: [Media]?
    public let user: [User]?
}

// MARK: - Media
public struct Media: Codable {
   public let id, blogID, createdAt: String?
   public let image: String?
   public let title: String?
   public let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, image, title, url
    }
}

// MARK: - User
public struct User: Codable {
   public let id, blogID, createdAt, name: String?
   public let avatar: String?
   public let lastname, city, designation, about: String?

    enum CodingKeys: String, CodingKey {
        case id
        case blogID = "blogId"
        case createdAt, name, avatar, lastname, city, designation, about
    }
}
