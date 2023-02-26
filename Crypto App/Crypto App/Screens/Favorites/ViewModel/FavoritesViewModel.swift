//
//  FavoritesViewModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 29.01.2023.
//

import Foundation

final class FavoritesViewModel: CAViewModel {

    // MARK: - Properties
    var coins = [Coin]()

    var numberOfRows: Int {
        coins.count
    }

    // MARK: - Methods
    func coinForIndexPath(_ indexPath: IndexPath) -> Coin? {
        coins[indexPath.row]
    }

    func fetchFavorites(_ completion: @escaping (Error?) -> Void) {
        coins = []

        guard let uid = uid else {
            return
        }

        db.collection("users").document(uid).getDocument { (querySnapshot, err) in
            guard let data = querySnapshot?.data() else {
                return
            }
            let user = User(from: data)

            user.favorites?.forEach({ coinId in
                self.db.collection("coins").document(coinId).getDocument { (querySnapshot, err) in
                    if let err = err {
                        completion(err)
                    } else {
                        guard let data = querySnapshot?.data() else {
                            return
                        }
                        let coin = Coin(from: data)
                        self.coins.append(coin)
                        completion(nil)
                    }
                }
            })
        }
    }
}
