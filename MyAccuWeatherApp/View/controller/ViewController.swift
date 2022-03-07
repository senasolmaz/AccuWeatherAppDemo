//
//  ViewController.swift
//  MyAccuWeatherApp
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var scrollHeights: NSLayoutConstraint!
    @IBOutlet var lastSearchItemsView: UIStackView!
    @IBOutlet var searchView: UIView!
    
    var textValueS: String? = ""
    var dataViewModel = LocationViewModel()

    @IBAction func searchButton(_ sender: Any) {
        textValueS = searchTextfield.text?.lowercased()
        self.initViewModel()
        searchTextfield.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getInitializeForUI()
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
                UserDefaultsClass.shared.saveLastSearchTexts(word: self.textValueS!)
            }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async {
                self.view.stopLoading()
                self.showAlert("Location Api Error")
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
        dataViewModel.getLocationData(value: textValueS!)
    }
    
    func getInitializeForUI() {
      
        self.searchView.makeCornerRadius(radius: 15)
        self.scrollHeights.constant = 0
        self.searchTextfield.returnKeyType = .done
        registerTableViewCells()
        let searchHistory = UserDefaults.standard.object(forKey: "SearchDefault")
        if searchHistory != nil {
            for item in (searchHistory as! [String]) {
                self.lastSearchItemsView.addArrangedSubview(addLastSearchView(value: item, clickEvent: self))
                self.scrollHeights.constant = 50
            }
        }
    }

    private func registerTableViewCells() {
        let customCell = UINib(nibName: "SearchItemCell",
                                  bundle: nil)
        self.searchTableView.register(customCell,
                                forCellReuseIdentifier: "searchItemCell")
    }
     
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataViewModel.locations.count == 0 {
            return 0
        }else {
            return dataViewModel.locations.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchItemCell", for: indexPath) as? SearchItemCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = dataViewModel.locations[indexPath.row]
        cell.textItemLabel.text = cellVM.LocalizedName
        cell.countryItemLabel.text = cellVM.Country.LocalizedName
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier:
                                                        "ForestcastViewController") as? ForestcastViewController
        
        let cellVM = dataViewModel.locations[indexPath.row]
        
        vc?.title = cellVM.LocalizedName
        
        vc?.country = cellVM.Country.LocalizedName
        vc?.localizedName = cellVM.LocalizedName
        vc?.key = cellVM.Key
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textValueS = textField.text?.lowercased()
        UserDefaultsClass.shared.saveLastSearchTexts(word: textValueS!)
        self.initViewModel()
        textField.resignFirstResponder()
                
        return true
    }
    
}

extension ViewController: SearchHistoryButtonClickEvent {
    func onClickHistoryButton(sender: UIButton!) {
        textValueS = sender.configuration?.title
        searchTextfield.text = textValueS
        initViewModel()
    }
    
}
