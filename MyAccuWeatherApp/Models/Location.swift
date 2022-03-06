//
//  Location.swift
//  MyAccuWeatherApp
//
//

import Foundation

struct Location: Codable {
    
    var Key: String!
    var LocalizedName: String!
    var Country: Country
 
}

struct Country: Codable {
    
    var LocalizedName: String!
    
}


