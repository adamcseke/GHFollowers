//
//  RestClient.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 08..
//

import Foundation

enum GithubError: Error {
    case wrongURL
}

final class RestClient {
    static let shared = RestClient()
    
    struct Constants {
        static let baseUrl = "https://api.github.com/"
    }
    
    private init() {}

    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(GithubError.wrongURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
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
                        print(String(describing: exepction))
                    }
                }
            }
        }
        task.resume()
    }
    
    func request<T: Codable>(urlString: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(GithubError.wrongURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
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
                    let result = try decoder.decode ([T].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch let exepction {
                    DispatchQueue.main.async {
                        completion(.failure(exepction))
                        print(String(describing: exepction))
                    }
                }
            }
        }
        task.resume()
    }
}
