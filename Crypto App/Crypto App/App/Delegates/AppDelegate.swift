//
//  AppDelegate.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 14.01.2023.
//

import UIKit
import SnapKit
import FirebaseCore
import FirebaseFirestore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?

    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        FirebaseApp.configure()
        let db = Firestore.firestore()
        return true
    }

    private func setupWindow() {
        // Override point for customization after application launch.
        let viewController = AuthViewController(viewModel: AuthViewModel(user: User()))
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}
