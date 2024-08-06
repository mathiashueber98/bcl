//
//  NetworkManager.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//




import SwiftUI

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
    
    static var shared = NetworkManager()
    
    private init(){}
    
    func fetchNews(completion: @escaping (Result<[GamingNews], Error>) -> Void) {
                        
        guard let url = URL(string: URLS.news.rawValue) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
            
            do {
                let activities = try JSONDecoder().decode([GamingNews].self, from: data)
                completion(.success(activities))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchClubs(completion: @escaping (Result<[Lounge], Error>) -> Void) {
                        
        guard let url = URL(string: URLS.clubs.rawValue) else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
            
            do {
                let activities = try JSONDecoder().decode([Lounge].self, from: data)
                completion(.success(activities))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
