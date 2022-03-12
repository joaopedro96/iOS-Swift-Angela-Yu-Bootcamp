//
//  CryptoData.swift
//  ByteCoin
//
//  Created by Joao Pedro da Mata Gonçalves Ribeiro on 27/06/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CryptoData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
}
