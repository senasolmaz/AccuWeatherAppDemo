//
//  LocationViewModel.swift
//  MyAccuWeatherApp
//
//

import Foundation

class LocationViewModel {
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    let locationService: ServiceProtocol
    var locations: [Location] = [Location]()

    private var locationCellViewModels: [LocationListCellViewModel] = [LocationListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    init(locationService: ServiceProtocol = ApiService()) {
        self.locationService = locationService
    }
    
    func getLocationData(value: String){
//        showLoading?()
        locationService.fetchLocation(url: "search?q=\(value.lowercased())") { (success, data) in
            if success {
                self.createCell(datas: data)
//                self.hideLoading?()
            }else {
                self.showError?()
            }
        }
    }
    
    var numberOfCells: Int {
        return locationCellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> LocationListCellViewModel {
        return locationCellViewModels[indexPath.row]
    }
    
    func createCell(datas: [Location]){
        var vms = [LocationListCellViewModel]()
        for data in datas {
            vms.append(LocationListCellViewModel(key: data.Key, localizedName: data.LocalizedName, country: data.Country.LocalizedName))
        }
        locationCellViewModels = vms
    }
}

struct LocationListCellViewModel {
    let key: String!
    let localizedName: String!
    let country: String!
}
