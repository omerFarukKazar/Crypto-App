//
//  CryptoListViewModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 15.01.2023.
//

import Moya
import FirebaseFirestore

enum CryptoListChanges { // Enum for the network response situations.
    case didErrorOccured(_ error: Error)
    case didFetchCoins
}

final class CryptoListViewModel {
    // MARK: - Properties
    var changeHandler: ((CryptoListChanges) -> Void)? // Closure to handle responses
    private var coinsResponse: CoinsResponse? {
        didSet {
            self.changeHandler?(.didFetchCoins)
            // When network result is successful, this triggers the tableView.reloadData() on ViewController.
        }
    }

    // swiftlint:disable:next identifier_name
    private let db = Firestore.firestore()

    var numberOfRows: Int { // To set the TableView's number of rows.
        coinsResponse?.coins?.count ?? .zero
    }

    // MARK: - Methods
    /// Sends a get request to API by using MoyaProvider.
    /// Handles the failure and success cases by using a closure named changeHandler.
    func fetchCoins() {
        provider.request(.coins) { result in
            switch result {
            case .failure(let error):
                self.changeHandler?(.didErrorOccured(error))
            case .success(let response):
                do {
                    let coinsResponse = try JSONDecoder().decode(CoinsResponse.self, from: response.data)

                    self.addCoinsToFirebaseFirestore(coinsResponse.coins)

                    self.coinsResponse = coinsResponse
                } catch {
                    self.changeHandler?(.didErrorOccured(error))
                }
            }
        }
    }

    private func addCoinsToFirebaseFirestore(_ coins: [Coin]?) {
        guard let coins = coins else {
            return
        }
        coins.forEach { coin in
            do {
                guard let data = try coin.dictionary, let id = coin.id else {
                    return
                }

                db.collection("coins").document(id).setData(data) { error in

                    if let error = error {
                        self.changeHandler?(.didErrorOccured(error))
                    }
                }
            } catch {
                self.changeHandler?(.didErrorOccured(error))
            }
        }
    }
    /// Will be used to return Coin corresponding at the indexPath.row
    func coinForIndexPath(_ indexPath: IndexPath) -> Coin? {
        coinsResponse?.coins?[indexPath.row]
    }
}
