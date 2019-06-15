//
//  BitcoinPriceRepository.swift
//  BitcoinPriceChecker_rx
//
//  Created by soft on 6/14/19.
//  Copyright © 2019 soft. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import Alamofire

protocol IBitcoinPriceRepository {
    
    func getBitcoinPrice(value: String) -> Observable<Double>
    func getCurrencyList() -> Observable<[String]>
}

class BitcoinFetchingError : Error {}

class BitcoinPriceRepository: IBitcoinPriceRepository {
    
    func getCurrencyList() -> Observable<[String]> {
        let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
        return Observable<[String]>.just(currencyArray)
    }
    
    func getBitcoinPrice(value: String) -> Observable<Double> {
        return Observable<Double>.create({ (emitter) -> Disposable in
            Alamofire.request("https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC" + value, method: .get)
                .debugLog()
                .responseJSON { response in
                    print(response)
                    switch response.result {
                    case .success:
                        let bitcoinJSON : JSON = JSON(response.result.value!)
                        let price = bitcoinJSON["ask"].double
                        if let price = price {
                            emitter.onNext(price)
                        } else {
                            emitter.onError(BitcoinFetchingError())
                        }
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                    }
            }
            return Disposables.create()
        })
    }
}
