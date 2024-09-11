//
//  NetworkManaging.swift
//  weatherapiapp
//
//  Created by Anastasia Tochilova  on 28.09.2024.
//

import Foundation

// MARK: - NetworkManaging Protocol
protocol NetworkManaging {
    func fetchWeather(for city: String, completion: @escaping (Result<Double, Error>) -> Void)
}
