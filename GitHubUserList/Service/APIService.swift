//
//  APIService.swift
//  GitHubUserList
//
//  Created by EMCT on 2022/4/6.
//

import Foundation

struct Constants {
    static let baseUrl = "https://api.github.com/users"
}

enum APIError: Error {
    case failedToGetGitHubData
    case faieldToGetPersonalData
}

class APIService {
    static let shared = APIService()
    
    func fetchGitHubData(completion: @escaping (Result<[GithubResponse], Error>) -> Void) {
        guard let url = URL(string: Constants.baseUrl) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode([GithubResponse].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedToGetGitHubData))
            }
        }
        task.resume()
    }
    
    func fetchPersonalData(userUrl: String, completion: @escaping (Result<PersonalResponse, Error>) -> Void) {
        guard let url = URL(string: userUrl) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(PersonalResponse.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.faieldToGetPersonalData))
            }
        }
        task.resume()
    }
}
