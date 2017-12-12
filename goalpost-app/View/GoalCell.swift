//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Brian  Crowley on 12/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLabel : UILabel!
    @IBOutlet weak var goalTypeLabel : UILabel!
    @IBOutlet weak var goalProgressLabel : UILabel!

    func configure (description: String, type: GoalType, progress: Int) {
        goalDescriptionLabel.text = description
        goalTypeLabel.text = type.rawValue
        goalProgressLabel.text = String(describing: progress)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
