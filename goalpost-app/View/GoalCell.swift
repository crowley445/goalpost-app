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
    
    @IBOutlet weak var goalCompletedLabel: UIView!
    var completedView : UIView?
    
    func configure (goal: Goal) {
        goalDescriptionLabel.text = goal.goalDescription
        goalTypeLabel.text = goal.goalType
        goalProgressLabel.text = String(describing: goal.goalProgress)
        
        goalCompletedLabel.isHidden = goal.goalProgress < goal.goalCompletionValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
