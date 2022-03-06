//
//  SearchItemCell.swift
//  MyAccuWeatherApp
//
//

import UIKit

class SearchItemCell: UITableViewCell {
    @IBOutlet var countryItemLabel: UILabel!
    
    @IBOutlet var textItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
