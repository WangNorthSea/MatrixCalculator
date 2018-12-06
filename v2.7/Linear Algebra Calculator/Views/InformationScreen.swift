//
//  InformationScreen.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/6/11.
//  Copyright © 2018 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit

class InformationScreen: UIView {
    
    let image = UIImageView(image: UIImage(named: "image"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    func loadUI() {
        
        self.addSubview(image)
        
        image.snp.makeConstraints({(maker) in
            maker.width.equalTo(200)
            maker.height.equalTo(200)
            maker.center.equalTo(self.snp.center)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
