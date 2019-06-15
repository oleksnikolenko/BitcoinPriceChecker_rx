//
//  Extensions.swift
//  BitcoinPriceChecker_rx
//
//  Created by soft on 6/15/19.
//  Copyright © 2019 soft. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}
