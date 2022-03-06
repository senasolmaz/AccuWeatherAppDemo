//
//  ForecastViewModel.swift
//  MyAccuWeatherApp
//
//

import Foundation

class ForacastViewModel {
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
        
    let forecastService: ServiceProtocol
    
     public var forecastModel: Forecast! {
        didSet {
            self.reloadTableView?()
        }
    }
    
    init(forecastService: ServiceProtocol = ApiService()) {
        self.forecastService = forecastService
    }
    
    func getForecastData(value: String){
//        showLoading?()
        forecastService.fetchForestcast(key: value) { (success, data) in
            if success {
                self.forecastModel = data
//                self.hideLoading?()
            }else {
                self.showError?()
            }
        }
    }
}
