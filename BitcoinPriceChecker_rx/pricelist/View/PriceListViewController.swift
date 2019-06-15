//
//  PriceListVC.swift
//  BitcoinPriceChecker_rx
//
//  Created by soft on 6/14/19.
//  Copyright © 2019 soft. All rights reserved.
//

import UIKit
import RxSwift

class PriceListVC: BaseViewController {
    
    let viewModel: IPriceListVM = PriceListVM(bitcoinPriceRepository: BitcoinPriceRepository())
    let currencyPickerView = UIPickerView()
    let bitcoinImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bitcoin"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = #colorLiteral(red: 0.9450980392, green: 0.6549019608, blue: 0.2039215686, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var currencyArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel
            .currencyPriceWatcher
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (viewState) in
                self.priceLabel.text = String(viewState.value)
                self.priceLabel.textColor = viewState.wasIncreased == nil ? UIColor.yellow : (viewState.wasIncreased! ? UIColor.green : UIColor.red)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .currencyList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (currencyList) in
                self.currencyArray = currencyList
                self.currencyPickerView.reloadAllComponents()
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        
        let topImageContainerView = UIView()
        
        view.addSubview(topImageContainerView)
        view.addSubview(currencyPickerView)
        view.addSubview(priceLabel)
        topImageContainerView.addSubview(bitcoinImageView)
        view.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.5294117647, blue: 0.5921568627, alpha: 1)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        bitcoinImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bitcoinImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        bitcoinImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: currencyPickerView.topAnchor).isActive = true
        
        currencyPickerView.translatesAutoresizingMaskIntoConstraints = false
        currencyPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        currencyPickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        currencyPickerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        currencyPickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
}
