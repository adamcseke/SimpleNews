//
//  APICaller+News.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 01..
//

import Foundation

extension APICaller {
    
    public func getNews(query: String, completion: @escaping (Result<NewsInfo, Error>) -> Void) {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = Constants.baseURL + "?q=\(escapedQuery)"
        request(urlString: url, completion: completion)
    }
}
