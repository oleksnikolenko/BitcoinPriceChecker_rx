
//
//  ViewObject.swift
//  BitcoinPriceChecker_rx
//
//  Created by soft on 6/15/19.
//  Copyright © 2019 soft. All rights reserved.
//

import Foundation

class PriceViewObject {
    
    let value: Double
    let wasIncreased: Bool?
    
    init(value: Double, wasIncreased: Bool?) {
        self.value = value
        self.wasIncreased = wasIncreased
    }
}
