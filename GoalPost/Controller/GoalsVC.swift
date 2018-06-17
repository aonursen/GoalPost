//
//  ViewController.swift
//  GoalPost
//
//  Created by Arif Onur Şen on 23.02.2018.
//  Copyright © 2018 LiniaTech. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    
    var goal: [Goal] = []

    @IBOutlet weak var goalsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        goalsTable.dataSource = self
        goalsTable.delegate = self
        goalsTable.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreData()
        goalsTable.reloadData()
    }
    func fetchCoreData() {
        self.fetch { (success) in
            if success {
                if goal.count > 0 {
                    goalsTable.isHidden = false
                } else {
                    goalsTable.isHidden = true
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func goalBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "createGoalSegue", sender: nil)
    }
    
    
}


extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goal.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = goalsTable.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
            let goalContent = goal[indexPath.row]
            cell.configureCell(goal: goalContent)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.remove(indexPath: indexPath)
            self.fetchCoreData()
            self.goalsTable.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD") { (rowAction, indexPath) in
            self.addGoalFunc(indexPath: indexPath)
            self.goalsTable.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return [deleteAction, addAction]
    }
    
}

extension GoalsVC {
    func addGoalFunc(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let selectedGoal = goal[indexPath.row]
        
        if selectedGoal.goalCount < selectedGoal.goalCompletionValue {
            selectedGoal.goalCount += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not added: \(error.localizedDescription)")
        }
        
    }
    
    func remove(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(goal[indexPath.row])
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not deleted: \(error.localizedDescription)")
        }
    }
    
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goal = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}

