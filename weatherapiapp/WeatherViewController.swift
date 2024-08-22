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

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }
    // MARK: - Setup UI
    
    private func setupUI() {
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

        cityTextField.placeholder = "Enter city name"
        cityTextField.borderStyle = .roundedRect
        view.addSubview(cityTextField)

        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])

        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: cityTextField.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: cityTextField.trailingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

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

    // MARK: - Networking
    
    private func fetchWeather(for city: String) {
        let apiKey = "3ab42858a5c7d89f7e85f6b7d9bf8979"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Failed to fetch data."
                }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                   let main = json["main"] as? [String: Any],
                   let temp = main["temp"] as? Double {

                    DispatchQueue.main.async {
                        self.resultLabel.text = "Temperature in \(city): \(temp)°C"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.resultLabel.text = "City not found."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Failed to parse data."
                }
            }
        }

        task.resume()
    }
}
