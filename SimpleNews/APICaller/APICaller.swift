//
//  APICaller.swift
//  SimpleNews
//
//  Created by Adam Cseke on 2021. 12. 01..
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let baseURL = "https://newsapi.org/v2/everything"
        static let apiKey = "903340369ad544e693307613abcb3506"
    }
    
    private init() {}

    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        var authUrl = url
        authUrl.appendQueryParameters(["apiKey": Constants.apiKey])
        let task = URLSession.shared.dataTask(with: authUrl) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
            else if let data = data {
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch let exepction {
                    DispatchQueue.main.async {
                        completion(.failure(exepction))
                        print(exepction.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
}
