//
//  NetworkManager.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

import Foundation

enum CustomError: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
}

class NetworkManager {
    
    enum URLS: String {
        case clubs = "https://api.jsonserve.com/kF_a63"
        case news = "https://api.jsonserve.com/4pUNSv"
    }
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private func fetchData(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(CustomError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomError.invalidData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
    
    func fetchNews(completion: @escaping (Result<[GamingNews], Error>) -> Void) {
        fetchData(from: URLS.news.rawValue) { result in
            switch result {
            case .success(let data):
                do {
                    let news = try JSONDecoder().decode([GamingNews].self, from: data)
                    completion(.success(news))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchClubs(completion: @escaping (Result<[Lounge], Error>) -> Void) {
        fetchData(from: URLS.clubs.rawValue) { result in
            switch result {
            case .success(let data):
                do {
                    let clubs = try JSONDecoder().decode([Lounge].self, from: data)
                    completion(.success(clubs))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
