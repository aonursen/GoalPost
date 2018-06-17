//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Arif Onur Şen on 23.02.2018.
//  Copyright © 2018 LiniaTech. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var goalText: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        nextBtn.backgroundColor = #colorLiteral(red: 0.9372094225, green: 0.7923276069, blue: 0.6040955368, alpha: 1)
        goalText.delegate = self
        goalType = .shortTerm
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shortTermPressed(_ sender: Any) {
        self.goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    @IBAction func longTermPressed(_ sender: Any) {
        self.goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if goalText.text != "" {
            performSegue(withIdentifier: "completeGoalSegue", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "completeGoalSegue" {
            if let completeGoalVC = segue.destination as? CompleteGoalVC {
                completeGoalVC.initData(description: self.goalText.text, type: goalType)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalText.text = ""
        goalText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if goalText.text != "" {
            nextBtn.backgroundColor = #colorLiteral(red: 0.9372094225, green: 0.6745448742, blue: 0.2399725219, alpha: 1)
        } else {
            nextBtn.backgroundColor = #colorLiteral(red: 0.9372094225, green: 0.7923276069, blue: 0.6040955368, alpha: 1)
        }
    }

}
