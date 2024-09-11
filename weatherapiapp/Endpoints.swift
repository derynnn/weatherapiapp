//
//  Endpoints.swift
//  weatherapiapp
//
//  Created by Anastasia Tochilova  on 28.09.2024.
//

import Foundation

// MARK: - Endpoints
enum Endpoints {
    case weather(city: String)

    var url: URL? {
        switch self {
        case .weather(let city):
            var components = URLComponents(string: APIConstants.baseURL)
            components?.path = "/data/2.5/weather"
            components?.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: APIConstants.apiKey),
                URLQueryItem(name: "units", value: "metric") 
            ]
            return components?.url
        }
    }
}
