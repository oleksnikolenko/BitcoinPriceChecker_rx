//
//  BaseViewController.swift
//  BitcoinPriceChecker_rx
//
//  Created by soft on 6/14/19.
//  Copyright © 2019 soft. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    var disposeBag: DisposeBag!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.disposeBag = DisposeBag()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.disposeBag = nil
    }
}
