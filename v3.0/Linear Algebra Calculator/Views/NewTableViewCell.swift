//
//  NewTableViewCell.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/6/11.
//  Copyright © 2018 UCAS Developers. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = UIColor(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
            self.textLabel?.backgroundColor = UIColor(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
        }
        else {
            self.backgroundColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
            self.textLabel?.backgroundColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        }
    }
    
}
