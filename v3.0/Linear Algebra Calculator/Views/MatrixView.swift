//
//  MatrixView.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/11/21.
//  Copyright © 2018 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit

class MatrixView: UIView {

    private var labelArray: [UILabel] = []
    public var rows = 0
    public var columns = 0
    public var gridStringArray: [String] = []
    
    public var labelQuantity: Int {
        
        get {
            return rows * columns
        }
        
        set {
            if (newValue != rows * columns) {
                refreshLabelNumber(numbers: rows * columns)
            }
            else {
                refreshLabelNumber(numbers: newValue)
            }
            self.alpha = 1
        }
    }
    
    private func refreshLabelNumber(numbers: Int) {
        if self.subviews != [] {
            for i in self.subviews {
                i.removeFromSuperview()
            }
        }
        
        labelArray = []
        for _ in 1...numbers {
            let label = UILabel()
            label.backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
            //label.backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 100 / 255, alpha: 1)
            label.textColor = UIColor.white
            label.numberOfLines = 1
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.01
            label.textAlignment = NSTextAlignment.center
            labelArray.append(label)
        }
        
        drawUI()
    }
    
    private func drawUI() {
        self.backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        for i in 0..<labelArray.count {
            self.addSubview(labelArray[i])
        }
        
        let w = (Double(labelArray[0].superview!.frame.width) - Double(10 * (columns - 1))) / Double(columns)
        let h = (Double(labelArray[0].superview!.frame.height) - Double(10 * (rows - 1))) / Double(rows)
        
        for i in 0..<labelArray.count {
            labelArray[i].frame = CGRect(x: (w + 10.0) * Double(i % columns), y: (h + 10.0) * Double(i / columns), width: w, height: h)
        }
        
        drawMatrix(gridStringArray: gridStringArray)
    }
    
    private func drawMatrix(gridStringArray: [String]) {
        for i in 0..<rows {
            for j in 0..<columns {
                labelArray[i * columns + j].text = gridStringArray[i * columns + j]
            }
        }
        
        let smallestFontSize = getSmallestFontSize()
        for i in 0..<labelArray.count {
            labelArray[i].font = UIFont(name: ".SFUIText", size: smallestFontSize)
        }
    }
    
    private func getSmallestFontSize() -> CGFloat {
        var fontSize = labelArray[0].font.pointSize
       
        for i in 1..<labelArray.count {
            if fontSize > labelArray[i].font.pointSize {
                fontSize = labelArray[i].font.pointSize
            }
        }
        
        return fontSize
    }
}
