//
//  GoalCell.swift
//  GoalPost
//
//  Created by Arif Onur Şen on 23.02.2018.
//  Copyright © 2018 LiniaTech. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var goalCount: UILabel!
    @IBOutlet weak var completedView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(goal: Goal) {
        self.goalText.text = goal.goalText
        self.typeText.text = goal.goalType
        self.goalCount.text = String(describing: goal.goalCount)
        
        if goal.goalCount == goal.goalCompletionValue {
            self.completedView.isHidden = false
        } else {
            self.completedView.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
