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
        setupFirebase()
        setupWindow()
        return true
    }

    // MARK: - Methods
    private func setupFirebase() {
        FirebaseApp.configure()

        _ = Firestore.firestore()
    }

    private func setupWindow() {
        // Override point for customization after application launch.
        let viewController = AuthViewController(viewModel: AuthViewModel())
//        let viewController = FavoritesViewController(viewModel: FavoritesViewModel())
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}
