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
    var key: String!
    var localizedName: String!
    var country: String!
    
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
                self.view.stopLoading()
                self.showAlert("Forecast Api Error")
            }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async {
                self.view.showLoading()
            }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async {
                self.view.stopLoading()
            }
        }
        dataViewModel.getForecastData(value: key)
        
    }

    private func registerTableViewCells() {
        let customCell = UINib(nibName: "ForecastCell",
                                  bundle: nil)
        self.weatherTableView.register(customCell,
                                forCellReuseIdentifier: "ForecastCell")
    }
    
    func setHeaderData() {
        self.descriptionLabel.text = dataViewModel.forecastModel.Headline.Text
        self.cityNameLabel.text = localizedName
        self.countryNameLabel.text = country
        
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
