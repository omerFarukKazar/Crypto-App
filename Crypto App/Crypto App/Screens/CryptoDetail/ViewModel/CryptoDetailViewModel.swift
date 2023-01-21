//
//  CryptoDetailViewModel.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 20.01.2023.
//

import UIKit

final class CryptoDetailViewModel {
    // MARK: - Properties
    ///  Creating a coin instance with dependency injection and returning some of their properties in order to
    ///  pass them to DetailView.
    let coin: Coin

    var coinName: String? {
        coin.name
    }

    var price: String {
        coin.prettyPrice
    }

    var rate: String {
        coin.prettyChange
    }

    var iconUrl: URL {
        coin.iconUrl
    }

    init(coin: Coin) {
        self.coin = coin
    }

}
