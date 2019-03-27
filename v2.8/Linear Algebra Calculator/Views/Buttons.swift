//
//  Buttons.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/10.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit

class Buttons: UIButton {

    init() {
        super.init(frame:CGRect.zero)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
