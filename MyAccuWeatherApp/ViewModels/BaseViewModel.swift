//
//  BaseViewModel.swift
//  MyAccuWeatherApp
//

import Foundation

class BaseViewModel {
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    let serviceValue: ServiceProtocol
    
    init(serviceValue: ServiceProtocol = ApiService()) {
        self.serviceValue = serviceValue
    }
}
