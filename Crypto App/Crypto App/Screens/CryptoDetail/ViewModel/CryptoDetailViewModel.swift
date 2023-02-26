//
//  CryptoDetailViewModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 20.01.2023.
//

import UIKit
import Moya
import Charts
import FirebaseFirestore

@objc
protocol CryptoDetailDelegate: AnyObject {
    // With AnyObject protocol, delegates gains class like reference skill. That's how when
    // this delegate equalized with the one in VC they'll both point the same adress and changes in
    // ViewController side will affect ViewModel too.
    func didErrorOccured(_ error: Error)
    @objc optional func didFetchChart()
    func didCoinAddedToFavorites()
}

final class CryptoDetailViewModel {
    // MARK: - Properties
    ///  Creating a coin instance with dependency injection and returning some of their properties in order to
    ///  pass them to DetailView.
    let coin: Coin

    private(set) var chartResponse: ChartResponse? {
        // swiftlint:disable:next line_length
        // If fetchCharts() function returns success, chartResponse will be set and, didiFetchChart function of delegate will be triggered.
        didSet {
            delegate?.didFetchChart?()
        }
    }

    weak var delegate: CryptoDetailDelegate?

    private let defaults = UserDefaults.standard
    // swiftlint:disable:next identifier_name
    private let db = Firestore.firestore()

    var coinName: String? {
        coin.name
    }

    var price: String {
        coin.prettyPrice
    }

    var rate: String {
        coin.prettyChange
    }

    var isRatePositive: Bool {
        (coin.priceChange1h ?? .zero ) > .zero
    }

    var iconUrl: URL {
        coin.iconUrl
    }

    // MARK: Init
    init(coin: Coin) {
        self.coin = coin
    }

    // MARK: Methods
    /// Fetches Chart data and handles the response.
    /// Sends a request by using MoyaProvider. Handles the failure and success situations by using CryptoDetailDelegate.
    func fetchChart() {
        guard let id = coin.id else { return }
        provider.request(.chart(id: id, period: "24h")) { result in
            switch result {
            case .failure(let error):
                self.delegate?.didErrorOccured(error)
            case .success(let response):
                do {
                    let chartResponse = try JSONDecoder().decode(ChartResponse.self, from: response.data)
                    self.chartResponse = chartResponse
                } catch {
                    self.delegate?.didErrorOccured(error)
                }
            }
        }
    }

    func addFavorite() {
        guard let id = coin.id,
              let uid = defaults.string(forKey: UserDefaultConstants.uid.rawValue) else {
            return
        }

        db.collection("users").document(uid).updateData([
            "favorites": FieldValue.arrayUnion([id])
        ])

        delegate?.didCoinAddedToFavorites()
    }
}
