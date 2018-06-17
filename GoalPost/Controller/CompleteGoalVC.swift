//
//  CompleteGoalVC.swift
//  GoalPost
//
//  Created by Arif Onur Şen on 23.02.2018.
//  Copyright © 2018 LiniaTech. All rights reserved.
//

import UIKit

class CompleteGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var completedPoints: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        completedPoints.delegate = self
    }
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createBtnPressed(_ sender: Any) {
        save { (success) in
            if completedPoints.text != "" {
                if success {
                    self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        
        goal.goalText = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(completedPoints.text!)!
        goal.goalCount = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}
