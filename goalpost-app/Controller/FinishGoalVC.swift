//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Brian  Crowley on 13/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType : GoalType!
    
    func initWithData(description: String, type: GoalType){
        goalDescription = description
        goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.delegate = self
        
        let createButton = getButtonForAccessoryView(withTitle: "CREATE GOAL")
        createButton.addTarget(self, action: #selector(FinishGoalVC.createButtonWasTapped), for: .touchUpInside)
        
        pointsTextField.inputAccessoryView = createButton
    }

    @objc func createButtonWasTapped() {
        if pointsTextField.text == "" { return }
        save { (success) in
            dismissDetail()
        }
    }
    
    func save (completion: (_ success: Bool) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalProgress = Int32(0)
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save goal: \(error)")
            completion(false)
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
}
