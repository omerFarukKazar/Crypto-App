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
    let marketCap, availableSupply, totalSupply, priceChange1h: Double?
    let priceChange1d, priceChange1w: Double?
    let websiteURL: String?
    let twitterURL: String?
    let exp: [String]?

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
    var iconUrl: URL {
        guard let icon = icon,
              let iconUrl = URL(string: icon) else { fatalError("Icon URL not found!") }
        return iconUrl
    }

    var prettyPrice: String {
        guard let price = price else { return "-" }
        return "\(Double(round(pow(10, 5) * price) / pow(10, 5))) $"
    }

    var change: Double {
        guard let price = price else { return .zero }
        return Double(round(100 * (price * (priceChange1d ?? .zero))) / 100)
    }

    var prettyChange: String {
        guard let priceChange1d = priceChange1d else { return "-" }
        if change > .zero {
            return "↑ \(change) (\(priceChange1d)%) "
        } else if change < .zero {
            return "↓ \(change) (\(priceChange1d)%) "
        } else {
            return "(-) \(change) (\(priceChange1d)%) "
        }
    }
}

extension Coin {
    init(from dict: [String: Any]) {
        id = dict["id"] as? String
        icon = dict["icon"] as? String
        name = dict["name"] as? String
        symbol = dict["symbol"] as? String
        rank = dict["rank"] as? Int
        price = dict["price"] as? Double
        priceBtc = dict["priceBtc"] as? Double
        volume = dict["volume"] as? Double
        marketCap = dict["marketCap"] as? Double
        availableSupply = dict["availableSupply"] as? Double
        totalSupply = dict["totalSupply"] as? Double
        priceChange1h = dict["priceChange1h"] as? Double
        priceChange1d = dict["priceChange1d"] as? Double
        priceChange1w = dict["priceChange1w"] as? Double
        websiteURL = dict["websiteURL"] as? String
        twitterURL = dict["twitterURL"] as? String
        exp = dict["exp"] as? [String]
        print(dict)
    }
}
