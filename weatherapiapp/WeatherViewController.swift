//
//  ViewController.swift
//  weatherapiapp
//
//  Created by Anastasia Tochilova  on 22.08.2024.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - UI Elements
    let cityTextField = UITextField()
    let searchButton = UIButton(type: .system)
    let resultLabel = UILabel()
    
    // MARK: - Services
    let weatherService = WeatherService()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Header
        let headerLabel = UILabel()
        headerLabel.text = "Weather"
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        headerLabel.textAlignment = .center
        view.addSubview(headerLabel)

        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // TextField
        cityTextField.placeholder = "Enter city name"
        cityTextField.borderStyle = .roundedRect
        view.addSubview(cityTextField)

        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])

        // Search Button
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: cityTextField.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: cityTextField.trailingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Result Label
        resultLabel.font = UIFont.systemFont(ofSize: 18)
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Actions
    @objc private func searchButtonTapped() {
        guard let cityName = cityTextField.text, !cityName.isEmpty else {
            resultLabel.text = "Please enter a city name."
            return
        }

        fetchWeather(for: cityName)
    }

    // MARK: - Fetch Weather
    private func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let temperature):
                    self?.resultLabel.text = "Temperature in \(city): \(temperature)°C"
                case .failure(let error):
                    self?.resultLabel.text = "Failed to fetch weather: \(error.localizedDescription)"
                }
            }
        }
    }
}
