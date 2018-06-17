//
//  ButtonBackground.swift
//  GoalPost
//
//  Created by Arif Onur Şen on 23.02.2018.
//  Copyright © 2018 LiniaTech. All rights reserved.
//

import UIKit

extension UIButton {

    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }

}
