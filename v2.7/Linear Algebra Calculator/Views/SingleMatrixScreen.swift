//
//  SingleMatrixScreen.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/10.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit

class SingleMatrixScreen: UIView {

    let label1 = UILabel()
    let label2 = UILabel()
    let figureArray:Array<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var inputString = ""
    var backupString = ""
    var backupString2 = ""
    var row = 1
    var firstLineColumn = 1
    var column = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    func loadUI() {

        self.addSubview(label1)
        self.addSubview(label2)
        
        label1.backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        label2.backgroundColor = UIColor(red: 67 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1)
        label1.textColor = UIColor.white
        label2.textColor = UIColor.white
        label1.numberOfLines = 0
        label2.numberOfLines = 1
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label2.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.adjustsFontSizeToFitWidth = true
        label2.adjustsFontSizeToFitWidth = true
        label1.textAlignment = NSTextAlignment.center
        
        label1.snp.makeConstraints({(maker) in
            maker.top.equalTo(85)
            maker.left.equalTo(70)
            maker.right.equalTo(-70)
            maker.bottom.equalTo(-55)
        })
        label2.snp.makeConstraints({(maker) in
            maker.left.equalTo(70)
            maker.bottom.equalTo(label1.snp.top)
            maker.width.equalTo(label1.snp.width)
            maker.height.equalTo(30)
        })
    }
    
    func deleteInput() {
        if inputString.count > 0 {
            if figureArray.contains(inputString.last!) || inputString.last! == "." || inputString.last! == "-" || inputString.last! == "/" {
                inputString.remove(at: inputString.index(before: inputString.endIndex))
                label1.text = inputString
                return
            }
            else {
                while inputString.last! == " " {
                    inputString.remove(at: inputString.index(before: inputString.endIndex))
                }
                label1.text = inputString
                if row == 1 {
                    if firstLineColumn != 1 {
                        firstLineColumn -= 1
                    }
                }
                else {
                    if column != 1 {
                        column -= 1
                    }
                }
            }
            if inputString.count > 0 {
                if inputString.last! == "\n" {
                    inputString.remove(at: inputString.index(before: inputString.endIndex))
                    inputString.remove(at: inputString.index(before: inputString.endIndex))
                    label1.text = inputString
                    row -= 1
                    if row == 1 {
                        column = 1
                    }
                    else {
                        column = firstLineColumn
                    }
                }
            }
         }
    }
    
    func clearScreen() {
        label1.text = ""
        label2.text = ""
        inputString = ""
        row = 1
        column = 1
        firstLineColumn = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
