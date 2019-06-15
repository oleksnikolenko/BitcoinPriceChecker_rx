//
//  PriceListVM.swift
//  BitcoinPriceChecker_rx
//
//  Created by soft on 6/14/19.
//  Copyright © 2019 soft. All rights reserved.
//

import Foundation
import RxSwift

protocol IPriceListVM {
    
    var currencyPriceWatcher: Observable<PriceViewObject>{get}
    
    func acceptCurrency(value: String)
    
    var currencyList: Observable<[String]> {get}
}

class PriceListVM : IPriceListVM {
    
    private let bitcoinPriceRepository: IBitcoinPriceRepository
    
    private let rxCurrency = ReplaySubject<String>.create(bufferSize: 1)
    
    var currencyList: Observable<[String]> {
        get {
            return bitcoinPriceRepository.getCurrencyList()
        }
    }
    
    init(bitcoinPriceRepository: IBitcoinPriceRepository) {
        self.bitcoinPriceRepository = bitcoinPriceRepository
    }

    lazy var currencyPriceWatcher: Observable<PriceViewObject> = rxCurrency
        .flatMapLatest { (value) in
            Observable<Int>
                .timer(0, period: 3.0, scheduler: MainScheduler.instance)
                .concatMap({ (_) in
                    self.bitcoinPriceRepository.getBitcoinPrice(value: value)
                })
                .scan(PriceViewObject(value: 0, wasIncreased: nil)) { (previous, current) -> PriceViewObject in
                    var increaseState: Bool? = nil
                    if previous.value > current {
                        increaseState = false
                    } else if previous.value < current && previous.value != 0 {
                        increaseState = true
                    }
                    return PriceViewObject(value: current, wasIncreased: increaseState)
            }
        }
    
    func acceptCurrency(value: String) {
        rxCurrency.onNext(value)
    }
}
