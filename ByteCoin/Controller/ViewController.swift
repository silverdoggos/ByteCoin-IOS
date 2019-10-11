//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController{
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLable: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.getCoinPrice(coinManager.currencyArray[0])
    }
}
//MARK: Picker View
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency: String = coinManager.currencyArray[row]
        coinManager.getCoinPrice(selectedCurrency)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
}

//MARK: NEWDATA
extension ViewController: CoinManagerDelegate {
    func didUodatePrice(price: String, currency: String){
        DispatchQueue.main.async {
            self.bitcoinLable.text = price
            self.currencyLabel.text = currency
        }
    }
    
    
    func didFailWithError(error: Error){
        print("error")
    }
}


    
    


