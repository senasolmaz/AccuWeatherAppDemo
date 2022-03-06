//
//  ViewController.swift
//  MyAccuWeatherApp
//

import UIKit

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
            DispatchQueue.main.async { self.searchTableView.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async {
//                self.showAlert("Ups, something went wrong.")
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
        dataViewModel.getLocationData(value: textValueS!)
    }
    
    func getInitializeForUI() {
      
        self.searchView.makeCornerRadius(radius: 15)
        self.scrollHeights.constant = 0
        self.searchTextfield.returnKeyType = .done
        registerTableViewCells()
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
        print(dataViewModel.numberOfCells)
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchItemCell", for: indexPath) as? SearchItemCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        
        cell.textItemLabel.text = cellVM.localizedName
        cell.countryItemLabel.text = cellVM.country
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier:
                                                        "ForestcastViewController") as? ForestcastViewController
        
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        
        vc?.title = cellVM.localizedName
        vc?.locationCellViewModel = cellVM
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textValueS = textField.text?.lowercased()
        self.initViewModel()
        textField.resignFirstResponder()
                
        return true
    }
    
}
