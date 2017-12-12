//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Brian  Crowley on 12/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func shortTermButtonWasPressed(_ sender: Any) {
    }
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
    }
    @IBAction func nextButtonWasPressed(_ sender: Any) {
    }
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
}
