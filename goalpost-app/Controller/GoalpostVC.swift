//
//  ViewController.swift
//  goalpost-app
//
//  Created by Brian  Crowley on 12/12/2017.
//  Copyright © 2017 Brian Crowley. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalpostVC: UIViewController {

    
    @IBOutlet weak var goalRemovedNotice: GoalRemovedNoticeView!
    @IBOutlet weak var tableView: UITableView!
    var goalsArray : [Goal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        goalRemovedNotice.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
    }

    func fetchCoreDataObjects() {
        fetch { (success) in
            tableView.isHidden = goalsArray.count > 0 ? false : true
            tableView.reloadData()
        }
    }
    
    func showUndoView () {
        let undoFrame = CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50)
        let undoView = UIView(frame: undoFrame)
        undoView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        view.addSubview(undoView)
    }
    
    @IBAction func addGoalButtonPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoButtonPressed(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.undoManager?.undo()
        
        fetchCoreDataObjects()
        
        goalRemovedNotice.fadeOut()
    }
    
    
}

extension GoalpostVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
            cell.configure(goal: goalsArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            tableView.beginUpdates()
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            self.goalRemovedNotice.fadeIn()
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            tableView.beginUpdates()
            self.setProgress(atIndexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        
        if goalsArray[indexPath.row].goalProgress == goalsArray[indexPath.row].goalCompletionValue {
            return [deleteAction]
        }
        
        return [deleteAction, addAction]
    }
}

extension GoalpostVC {
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let goal = goalsArray[indexPath.row]
        
        if goal.goalProgress < goal.goalCompletionValue {
            goal.goalProgress += 1
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
        }
    }
    
    func removeGoal (atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(goalsArray[indexPath.row])
        managedContext.undoManager = UndoManager()
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
        }
    }
    
    func undoDelete() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.undoManager?.undo()
    }
    
    func fetch (completion: (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goalsArray = try managedContext.fetch(request)
            completion(true)
        } catch {
            debugPrint("Could not fetch goals: \(error.localizedDescription)")
            completion(false)
        }
    }
}

