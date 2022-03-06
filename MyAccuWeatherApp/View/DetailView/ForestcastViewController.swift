//
//  ForestcastViewController.swift
//  MyAccuWeatherApp
//
//

import UIKit

class ForestcastViewController: UIViewController {

    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var countryNameLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherTableView: UITableView!
    
    var dataViewModel = ForacastViewModel()
    var locationCellViewModel: LocationListCellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        registerTableViewCells()
        self.initViewModel()
       
    }
    
    func initViewModel(){
        
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
                self.setHeaderData()
            }
        }
        
        dataViewModel.showError = {
            DispatchQueue.main.async {
                self.removeLoadingView()
            }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async {
                self.createLoadingView()
            }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async {
                self.removeLoadingView()
            }
        }
        dataViewModel.getForecastData(value: (locationCellViewModel!.key))
        
    }

    private func registerTableViewCells() {
        let customCell = UINib(nibName: "ForecastCell",
                                  bundle: nil)
        self.weatherTableView.register(customCell,
                                forCellReuseIdentifier: "ForecastCell")
    }
    
    func setHeaderData() {
        self.descriptionLabel.text = dataViewModel.forecastModel.Headline.Text
        self.cityNameLabel.text = locationCellViewModel?.localizedName
        self.countryNameLabel.text = locationCellViewModel?.country
        
    }

}

extension ForestcastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataViewModel.forecastModel == nil {
            return 0
        }else {
        return dataViewModel.forecastModel.DailyForecasts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else {
            fatalError("ForecastCell error")
        }
        let cellVM = dataViewModel.forecastModel.DailyForecasts[indexPath.row]
       
        if indexPath.row == 0 {
            cell.forecastDateLabel.text = "Bugün"
        }
        else if indexPath.row == 1 {
            cell.forecastDateLabel.text = "Yarın"
        }else {
            cell.forecastDateLabel.text = cellVM.Date.convertDate()
        }
        cell.tempratureTextLabel.text = cellVM.Day.IconPhrase
        cell.tempratureLabel.text = String("\(cellVM.Temperature.Maximum.Value)° F")
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}
