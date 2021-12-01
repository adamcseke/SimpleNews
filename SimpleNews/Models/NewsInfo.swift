//
//  NewsInfo.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 01..
//

import Foundation

// MARK: - NewsInfo
struct NewsInfo: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
