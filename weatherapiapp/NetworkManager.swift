//
//  NetworkManager.swift
//  weatherapiapp
//
//  Created by Anastasia Tochilova  on 28.09.2024.
//

import Foundation

// MARK: - NetworkManager
final class NetworkManager: NetworkManaging {

    // MARK: - Public Methods
    func fetchWeather(for city: String, completion: @escaping (Result<Double, Error>) -> Void) {
        guard let url = Endpoints.weather(city: city).url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                   let main = json["main"] as? [String: Any],
                   let temp = main["temp"] as? Double {
                    completion(.success(temp))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }

        task.resume()
    }
}
