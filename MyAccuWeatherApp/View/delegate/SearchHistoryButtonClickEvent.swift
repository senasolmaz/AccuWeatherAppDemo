//
//  SearchHistoryButtonClickEvent.swift
//  MyAccuWeatherApp
//

import UIKit
import Foundation

@objc
protocol SearchHistoryButtonClickEvent {
    
    func onClickHistoryButton(sender: UIButton!)
}
