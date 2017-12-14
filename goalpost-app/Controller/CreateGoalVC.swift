//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Brian  Crowley on 12/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    
    var placeholderText : String?
    var goalType : GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        descriptionTextView.delegate = self
        placeholderText = descriptionTextView.text
        
        let nextButton = getButtonForAccessoryView(withTitle: "NEXT")
        nextButton.addTarget(self, action: #selector(CreateGoalVC.nextButtonWasTapped), for: .touchUpInside)

        descriptionTextView.inputAccessoryView = nextButton
    }
    
    @IBAction func shortTermButtonWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermButton.setSelectedColor()
        shortTermButton.setDeselectedColor()
    }

    @objc func nextButtonWasTapped() {
        if (descriptionTextView.text == "" || descriptionTextView.text == placeholderText) { return }
        guard let finishVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
        finishVC.initWithData(description: descriptionTextView.text, type: goalType)
        presentingViewController?.presentSecondaryDetail(finishVC)
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (descriptionTextView.text == placeholderText!) {
            descriptionTextView.text = ""
            descriptionTextView.textColor = UIColor.black
        }
    }
}
