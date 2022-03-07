//
//  ForecastCell.swift
//  MyAccuWeatherApp
//
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet var weatherIconView: UIImageView!
    @IBOutlet var tempratureTextLabel: UILabel!
    @IBOutlet var tempratureLabel: UILabel!
    @IBOutlet var forecastDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
