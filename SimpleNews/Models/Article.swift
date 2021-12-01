//
//  Article.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 01..
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String
    let title: String
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String
    var isFavorite: Bool? = false

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
        case isFavorite
    }
}
