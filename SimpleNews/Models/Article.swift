//
//  Article.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 01..
//

import Foundation

// MARK: - Article
struct Article: Codable, Equatable {
    let source: Source
    let author: String
    let title: String
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String
    var isFavorite: Bool {
        get { _isFavorite ?? false }
        set { _isFavorite = newValue }
    }
    
    private var _isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
        case _isFavorite = "isFavorite"
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.url == rhs.url
    }
}
