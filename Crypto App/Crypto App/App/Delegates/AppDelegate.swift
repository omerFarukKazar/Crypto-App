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
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
        if UserDefaults.standard.bool(forKey: "didSignedIn") == false {

            let viewController = AuthViewController(viewModel: AuthViewModel())
            let window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window

        } else {

            let viewController = setTabBar()
            let window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window

        }
    }

    func setTabBar() -> UITabBarController {
        let cryptoListViewModel = CryptoListViewModel()
        let cryptoListViewController = CryptoListViewController(viewModel: cryptoListViewModel)

        let favoritesViewModel = FavoritesViewModel()
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)

        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [cryptoListViewController,
                                            favoritesViewController,
                                            profileViewController]

        tabBarController.tabBar.items?[0].image = UIImage(named: "home")
        tabBarController.tabBar.items?[0].title = "Coins"
        tabBarController.tabBar.items?[1].image = UIImage(named: "favorite")
        tabBarController.tabBar.items?[1].title = "Favorites"
        tabBarController.tabBar.items?[2].image = UIImage(named: "person")
        tabBarController.tabBar.items?[2].title = "Profile"
        // These titles and images could be set with a mapping function and by using enums.

        return tabBarController
    }

}
