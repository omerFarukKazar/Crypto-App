//
//  ChartResponse.swift
//  Crypto App
//
//  Created by Ömer Faruk Kazar on 21.01.2023.
//

import Foundation

struct ChartResponse: Decodable {
    let chart: [[Double]]?
}
