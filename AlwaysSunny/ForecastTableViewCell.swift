// TODO: add the min and max temps of the day from the json obj
//
//  ForecastTableViewCell.swift
//  AlwaysSunny
//
//  Created by Will Wyatt on 12/5/15.
//  Copyright © 2015 Will Wyatt. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    //****  OUTLETS  ****//
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var forecastDayLabel: UILabel!
    @IBOutlet weak var forecastDescriptionLabel: UILabel!
// TODO: add the min and max temps of the day from the json obj
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
