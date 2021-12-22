//
//  APICaller+News.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 01..
//

import Foundation

extension APICaller {
    
    public func searchNews(query: String, completion: @escaping (Result<NewsInfo, Error>) -> Void) {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = Constants.baseURL + "everything?q=\(escapedQuery)"
        request(urlString: url, completion: completion)
    }
    public func getNews(country: String, category: String, completion: @escaping (Result<NewsInfo, Error>) -> Void) {
        let url = Constants.baseURL + "top-headlines?" + "country=\(country)" + "&category=\(category)"
        request(urlString: url, completion: completion)
    }
}
