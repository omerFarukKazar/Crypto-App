//
//  CryptoAPI.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 14.01.2023.
//

import Moya

enum CoinStatsAPI { // Enum for different request paths.
    case coins
    case chart(id: String, period: String) // API needs two parameters for queries
}

extension CoinStatsAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.coinstats.app/public/v1") else { fatalError("url not found.") }
        return url
    }

    var path: String {
        switch self {
        case .coins:
            return "coins"
        case .chart:
            return "charts"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        switch self {
        case .coins:
               return .requestPlain // returns "coins"
        case .chart(let id, let period):
            let parameters = ["coinId": id,
                              "period": period]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            // Since the get method can be sent without packaging, used URLEncoding.queryString
        }
    }

    var headers: [String: String]? {
        nil
    }

}
