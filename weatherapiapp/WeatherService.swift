//
//  WeatherService.swift
//  weatherapiapp
//
//  Created by Anastasia Tochilova  on 01.09.2024.
//

import Foundation

// MARK: - WeatherService
class WeatherService {
    
    // MARK: - Properties
    private let apiKey = "3ab42858a5c7d89f7e85f6b7d9bf8979" 

    // MARK: - Public Methods
    func fetchWeather(for city: String, completion: @escaping (Result<Double, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 500, userInfo: nil)))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                   let main = json["main"] as? [String: Any],
                   let temp = main["temp"] as? Double {
                    completion(.success(temp))
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 404, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

