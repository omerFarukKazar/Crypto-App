//
//  CoinsResponse.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 15.01.2023.
//

import Foundation

struct CoinsResponse: Decodable {
    let coins: [Coin]?
}
