//
//  LocationViewModel.swift
//  MyAccuWeatherApp
//
//

import Foundation

class LocationViewModel: BaseViewModel {
    
    public var locations: [Location] = [Location]() {
        didSet {
            self.reloadTableView?()
        }
    }
    func getLocationData(value: String){
        showLoading?()
        serviceValue.fetchLocation(url: "search?q=\(value.lowercased())") { (success, data) in
            if success {
                self.locations = data
                self.hideLoading?()
            }else {
                self.showError?()
                self.hideLoading?()
            }
        }
    }
}
