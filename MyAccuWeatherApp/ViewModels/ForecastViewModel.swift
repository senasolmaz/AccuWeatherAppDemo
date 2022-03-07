//
//  ForecastViewModel.swift
//  MyAccuWeatherApp
//
//

import Foundation

class ForacastViewModel: BaseViewModel {
    
     public var forecastModel: Forecast! {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getForecastData(value: String){
        showLoading?()
        serviceValue.fetchForestcast(key: value) { (success, data) in
            if success {
                self.forecastModel = data
                self.hideLoading?()
            }else {
                self.showError?()
                self.hideLoading?()
            }
        }
    }
}
