//
//  GoalRemovedNoticeView.swift
//  goalpost-app
//
//  Created by Brian  Crowley on 14/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class GoalRemovedNoticeView: UIView {

    func fadeIn () {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func fadeOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (success) in
            self.isHidden = true
        }
    }
}
