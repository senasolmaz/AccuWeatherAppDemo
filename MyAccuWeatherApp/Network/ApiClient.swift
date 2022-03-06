//
//  ApiClient.swift
//  MyAccuWeatherApp
//
//

import Foundation
import Alamofire


protocol ServiceProtocol {
    
    func fetchLocation(url: String, completion: @escaping (_ success: Bool,_  result: [Location]) -> ())
    func fetchForestcast(key: String, completion: @escaping (_ success: Bool,_  result: Forecast) -> ())
}

class ApiService: ServiceProtocol {
    
    let baseUrl = "http://dataservice.accuweather.com/"
    let apiKey = "Nx8fVetx3yB9xfvSAql3kICyQFTU1hHK"
    
    func fetchLocation(url: String, completion: @escaping (Bool, [Location]) -> ()) {
        
        DispatchQueue.global().async {
            AF.request("\(self.baseUrl)locations/v1/\(url)&apikey=\(self.apiKey)", method: .get).responseDecodable(of: [Location].self) { (response) in
                switch response.result {
                case let .success(data):
                    completion(true, data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            
            }
            
        }
    }
    
    func fetchForestcast(key: String, completion: @escaping (Bool, Forecast) -> ()) {
      
        DispatchQueue.global().async {
            AF.request("\(self.baseUrl)forecasts/v1/daily/5day/\(key)?apikey=\(self.apiKey)&language=tr-TR", method: .get).responseDecodable(of: Forecast.self) { (response) in
                switch response.result {
                case let .success(data):
                    completion(true, data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            
            }
            
        }
    }

}

