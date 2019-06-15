//
//  PriceListVCExtensiom.swift
//  BitcoinPriceChecker_rx
//
//  Created by soft on 6/15/19.
//  Copyright © 2019 soft. All rights reserved.
//

import UIKit
import RxSwift

extension PriceListVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.acceptCurrency(value: currencyArray[row])
    }
    
}
