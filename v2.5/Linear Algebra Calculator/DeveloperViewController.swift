//
//  InformationViewController.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/31.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit

class DeveloperViewController: UIViewController {

    let label = UILabel()
    let back = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(click))
        self.view.addGestureRecognizer(swip)
        loadUI()
    }

    @objc func click() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadUI() {
        
        self.view.backgroundColor = UIColor(red: 67 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1)
        self.view.addSubview(label)
        self.view.addSubview(back)
        
        back.frame = CGRect(x:10, y:30, width:65, height:32)
        back.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        back.setImage(UIImage(named: "BackHighlighted"), for: UIControlState.highlighted)
        back.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        label.snp.makeConstraints({(maker) in
            maker.top.equalTo(70)
            maker.left.equalTo(50)
            maker.width.equalTo(label.superview!.frame.width - 100)
            maker.height.equalTo(label.superview!.frame.height - 140)
        })
        
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red: 67 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "    这是我制作的第一个App，如有不完善之处请见谅\n    你也许会注意到本App的图标和启动图片上都绘有同样的一个3阶满秩矩阵，这个矩阵并不是我随意绘制的。我最早实现这个App所具有的功能时是用的C语言，也是自那之后，我才诞生了把对矩阵的计算做到iOS平台上的想法。我写C语言时，用来测试程序的矩阵中，被我用得次数最多的就是本App图标以及启动图片上绘制的那个矩阵。为了纪念那段时光，我把它放在了最显眼的位置\n    如果你在使用过程中发现了一些问题，或者你也对iOS开发感兴趣，可以发送邮件到：\nwanghaoyu171@mails.ucas.ac.cn\n与我取得联系"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
