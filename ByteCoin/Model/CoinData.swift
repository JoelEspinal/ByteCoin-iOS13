//
//  CoinData.swift
//  ByteCoin
//
//  Created by Joel Espinal (JoelEspinal) on 19/2/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation


struct result: Codable {
    let rates: [CoinData]
}

struct CoinData: Codable {
    var rate: Double
    
}

