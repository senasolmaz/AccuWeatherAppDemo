//
//  String+Extensions.swift
//  MyAccuWeatherApp
//

import Foundation

extension String {
    
    func convertDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "EEEE"
        let resultString = dateFormatter.string(from: date!)
        print(resultString)
        
        return resultString
    }
}
