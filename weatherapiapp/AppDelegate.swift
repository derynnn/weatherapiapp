//
//  AppDelegate.swift
//  weatherapiapp
//
//  Created by Anastasia Tochilova  on 22.08.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - Application Lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = WeatherViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
