//
//  Forestcast.swift
//  MyAccuWeatherApp
//

import Foundation


struct Forecast: Codable {
    
    var Headline: Headline
    var DailyForecasts: [DailyForecasts]
 
}

struct Headline: Codable {
    var Text: String
    var Category: String
}
struct DailyForecasts: Codable {
    
    var Date: String!
    var Temperature: Temperature
    var Day: Day
    
}
struct Temperature: Codable {
    
    var Maximum: Maximum
    
}
struct Maximum: Codable {
    
    var Value: Int
    
}
struct Day: Codable {
    
    var Icon: Int
    var IconPhrase: String
    
}
