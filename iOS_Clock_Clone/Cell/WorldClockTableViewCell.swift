//
//  WorldClockTableViewCell.swift
//  iOS_Clock_Clone
//
//  Created by 김정원 on 8/27/24.
//

import UIKit

class WorldClockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeOffsetLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
