//
//  UserDefaultsClass.swift
//  MyAccuWeatherApp
//

import Foundation

class UserDefaultsClass {
    
    let userDefaults = UserDefaults.standard
    var searchDefaultsKey = "SearchDefault"
    var wordsArray = [String]()
    static var shared = UserDefaultsClass()
    
    func saveLastSearchTexts(word: String) {
        if userDefaults.object(forKey: searchDefaultsKey) != nil {
            wordsArray = userDefaults.object(forKey: searchDefaultsKey) as! [String]
        }
        
        if wordsArray.count < 5 {
            if !wordsArray.contains(word.lowercased())  {
                self.wordsArray.append(word.lowercased())
                userDefaults.set(wordsArray, forKey: searchDefaultsKey)
            }
        }else if wordsArray.count == 5 && wordsArray.count < 7{
            wordsArray.remove(at: 0)
            if !wordsArray.contains(word.lowercased())  {
                self.wordsArray.append(word.lowercased())
                userDefaults.set(wordsArray, forKey: searchDefaultsKey)
            }
        }
    }
    
}
