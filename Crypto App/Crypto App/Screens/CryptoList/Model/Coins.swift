//
//  Coins.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 15.01.2023.
//

import Foundation

struct Coin: Decodable {
    let id: String?
    let icon: String?
    let name, symbol: String?
    let rank: Int?
    let price, priceBtc: Double?
    let volume: Double?
    let marketCap, availableSupply, totalSupply, priceChange1H: Double?
    let priceChange1D, priceChange1W: Double?
    let websiteURL: String?
    let twitterURL: String?
    let exp: [String]?
    let contractAddress: String?
    let decimals: Int?
    let redditURL: String?

//    enum CodingKeys: String, CodingKey {
//        case id, icon, name, symbol, rank, price, priceBtc, volume, marketCap, availableSupply, totalSupply
//        case priceChange1H = "priceChange1h"
//        case priceChange1D = "priceChange1d"
//        case priceChange1W = "priceChange1w"
//        case websiteURL = "websiteUrl"
//        case twitterURL = "twitterUrl"
//        case exp, contractAddress, decimals
//        case redditURL = "redditUrl"
//    }
}

extension Coin {
    var iconUrl: URL? {
        guard let icon = icon,
              let iconUrl = URL(string: icon) else { fatalError("Icon URL not found!") }
        return iconUrl
    }

    var prettyPrice: String? {
        guard let price = price else { return "-"}
        return "\(Double(round(pow(10, 5) * price) / pow(10, 5))) $"
    }

}
