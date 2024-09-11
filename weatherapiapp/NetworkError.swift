//
//  NetworkError.swift
//  weatherapiapp
//
//  Created by Anastasia Tochilova  on 28.09.2024.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case requestFailed
    case invalidResponse

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was returned from the request."
        case .decodingError:
            return "Failed to decode the response data."
        case .requestFailed:
            return "The network request failed."
        case .invalidResponse:
            return "The server returned an invalid response."
        }
    }
}
