//
//  InverseViewController.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/10.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit
import AudioToolbox

class JordanViewController: UIViewController, KeyboardButtonClicked, UITextFieldDelegate, SavedMatricesDelegate {
    
    let Alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let alphabet: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    let keyboard = Keyboard()
    let screen = SingleMatrixScreen()
    let calculate = CalculatorEngine()
    let back = UIButton()
    let save = UIButton()
    let load = UIButton()
    let export = UIButton()
    var check = true
    var numberCount = 0
    let savedMatrices = SavedMatrices()
    let alertController1 = UIAlertController(title: "警告", message: "请先输入一个矩阵哦～！", preferredStyle: UIAlertControllerStyle.alert)
    let alertController2 = UIAlertController(title: "警告", message: "只有矩阵才可以执行此操作哦～！", preferredStyle: UIAlertControllerStyle.alert)
    let alertController3 = UIAlertController(title: "保存矩阵", message: "请输入矩阵名称\n若名称已存在则会覆盖原矩阵\n只能输入一个字母", preferredStyle: UIAlertControllerStyle.alert)
    let alertController4 = UIAlertController(title: "警告", message: "请将矩阵输入完毕哦～！", preferredStyle: UIAlertControllerStyle.alert)
    let alertController5 = UIAlertController(title: "导出成功", message: "LaTeX代码已复制到剪贴板！", preferredStyle: UIAlertControllerStyle.alert)
    let alertAction1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    let alertAction3 = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
    let alertAction4 = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    let alertAction5 = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    let alertAction6 = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    var matrixName = UITextField()
    var fileName: String = ""
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    var path: String = ""
    var savedMatrix: NSString = ""
    var output: NSString = ""
    var countOfSpace = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(click))
        self.view.backgroundColor = UIColor(red: 67 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1)
        self.view.addGestureRecognizer(swip)
        keyboard.delegate = self
        loadUI()
    }
    
    func loadUI() {
        self.view.addSubview(keyboard)
        self.view.addSubview(screen)
        self.view.addSubview(back)
        self.view.addSubview(save)
        self.view.addSubview(load)
        self.view.addSubview(export)
        
        back.frame = CGRect(x:10, y:30, width:65, height:32)
        back.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        back.setImage(UIImage(named: "BackHighlighted"), for: UIControlState.highlighted)
        back.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        save.frame = CGRect(x:self.view.frame.width - 75, y:30, width:65, height:32)
        save.setImage(UIImage(named: "Save"), for: UIControlState.normal)
        save.setImage(UIImage(named: "SaveHighlighted"), for: UIControlState.highlighted)
        save.addTarget(self, action: #selector(Save), for: .touchUpInside)
        
        load.frame = CGRect(x:self.view.frame.width - 75, y:self.view.frame.height / 2 - 40, width:65, height:32)
        load.setImage(UIImage(named: "Import"), for: UIControlState.normal)
        load.setImage(UIImage(named: "ImportHighlighted"), for: UIControlState.highlighted)
        load.addTarget(self, action: #selector(Load), for: .touchUpInside)
        
        export.frame = CGRect(x:10, y:self.view.frame.height / 2 - 40, width:65, height:32)
        export.setImage(UIImage(named: "Export"), for: UIControlState.normal)
        export.setImage(UIImage(named: "ExportHighlighted"), for: UIControlState.highlighted)
        export.addTarget(self, action: #selector(Export), for: .touchUpInside)
        
        keyboard.snp.makeConstraints({(maker) in
            maker.bottom.right.left.equalTo(0)
            maker.height.equalTo(keyboard.superview!.snp.height).multipliedBy(0.5)
        })
        screen.snp.makeConstraints({(maker) in
            maker.top.left.right.equalTo(0)
            maker.height.equalTo(screen.superview!.snp.height).multipliedBy(0.5)
        })
        
        let alertAction2 = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
            self.fileName = self.matrixName.text!
            self.savedMatrix = NSString(string: self.screen.label1.text!)
            try! self.savedMatrix.write(toFile: self.path + "/\(self.fileName).plist", atomically: true, encoding: 1)
        })
        
        alertController1.addAction(alertAction1)
        alertController2.addAction(alertAction4)
        alertController3.addAction(alertAction3)
        alertController3.addAction(alertAction2)
        alertController4.addAction(alertAction5)
        alertController5.addAction(alertAction6)
        alertController3.addTextField(configurationHandler: {(textField) in
            self.matrixName = textField
            self.matrixName.text = "A"
        })
        
        path = paths[0]
        matrixName.delegate = self
        savedMatrices.delegate = self
    }
    
    func didSelectRow(_ string: String) {
        try! output = NSString(contentsOfFile: self.path + "/\(string).plist", encoding: 1)
        screen.label1.text = String(output)
        screen.inputString = String(output)
        screen.label1.textColor = UIColor.white
        screen.row = 1
        screen.column = 1
        for i in screen.inputString {
            if i == "\n" {
                screen.row += 1
            }
        }
        for i in screen.inputString {
            if i == " " {
                countOfSpace += 1
            }
        }
        countOfSpace /= 3
        screen.firstLineColumn = countOfSpace / screen.row + 1
        if screen.row != 1 {
            screen.column = screen.firstLineColumn
        }
        countOfSpace = 0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string >= "A" && string <= "Z") || (string >= "a" && string <= "z")  {
            if string >= "a" && string <= "z" {
                for i in 0..<alphabet.count {
                    if string == alphabet[i] {
                        textField.text? = Alphabet[i]
                    }
                }
            }
            else {
                textField.text? = string
            }
            return false
        }
        else {
            return false
        }
    }
    
    @objc func click() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func Save() {
        
        if screen.inputString == "" {
            self.present(alertController1, animated: true, completion: nil)
        }
        else if (screen.label1.text?.contains("～"))! || (screen.label1.text?.contains("x"))! || (screen.label1.text?.contains("α"))! {
            self.present(alertController2, animated: true, completion: nil)
        }
        else if (screen.row != 1 && screen.column != screen.firstLineColumn) || !screen.figureArray.contains(screen.inputString.last!) {
            self.present(alertController4, animated: true, completion: nil)
        }
        else {
            self.present(alertController3, animated: true, completion: nil)
        }
    }
    
    @objc func Load() {
        self.view.addSubview(savedMatrices)
        savedMatrices.tableView.reloadSections([0], with: .none)
        savedMatrices.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {self.savedMatrices.alpha = 1}, completion: nil)
        savedMatrices.snp.makeConstraints({(maker) in
            maker.width.equalTo(300)
            maker.height.equalTo(350)
            maker.center.equalTo(savedMatrices.superview!.snp.center)
        })
    }
    
    @objc func Export() {
        
        if screen.inputString == "" {
            self.present(alertController1, animated: true, completion: nil)
        }
        else if (screen.label1.text?.contains("～"))! || (screen.label1.text?.contains("x"))! {
            self.present(alertController2, animated: true, completion: nil)
        }
        else if (screen.row != 1 && screen.column != screen.firstLineColumn) || !screen.figureArray.contains(screen.inputString.last!) {
            self.present(alertController4, animated: true, completion: nil)
        }
        else {
            self.present(alertController5, animated: true, completion: nil)
            let latexString = calculate.export(screen.inputString, screen.row, screen.firstLineColumn)
            UIPasteboard.general.string = latexString
        }
    }
    
    func buttonClicked(tag: Int) {
        if check {
            if screen.column <= screen.firstLineColumn {
                if tag == 0 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    if screen.inputString.count > 0 {
                        if screen.inputString.last! == "/" {
                            return
                        }
                        else {
                            screen.inputString.append("0")
                            screen.label1.text = screen.inputString
                        }
                    }
                    else {
                        screen.inputString.append("0")
                        screen.label1.text = screen.inputString
                    }
                }
                if tag == 1 {
                    if screen.inputString.count > 0 {
                        screen.backupString2 = screen.inputString
                        while screen.backupString2.last != nil && screen.figureArray.contains(screen.backupString2.last!) {
                            screen.backupString2.remove(at: screen.backupString2.index(before: screen.backupString2.endIndex))
                            if screen.backupString2.count > 0 {
                                if screen.backupString2.last! == "." {
                                    return
                                }
                            }
                        }
                        screen.backupString2 = ""
                        if screen.figureArray.contains(screen.inputString.last!) {
                            screen.inputString.append(".")
                            screen.label1.text = screen.inputString
                        }
                        else {
                            return
                        }
                    }
                }
                if tag == 2 {
                    if screen.inputString.count > 0 {
                        if !screen.figureArray.contains(screen.inputString.last!) && screen.inputString.last! != "-" && screen.inputString.last! != "." && screen.inputString.last! != "/" {
                            screen.inputString.append("-")
                            screen.label1.text = screen.inputString
                        }
                    }
                    else {
                        screen.inputString.append("-")
                        screen.label1.text = screen.inputString
                    }
                }
                if tag == 3 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("1")
                    screen.label1.text = screen.inputString
                }
                if tag == 4 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("2")
                    screen.label1.text = screen.inputString
                }
                if tag == 5 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("3")
                    screen.label1.text = screen.inputString
                }
                if tag == 6 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("4")
                    screen.label1.text = screen.inputString
                }
                if tag == 7 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("5")
                    screen.label1.text = screen.inputString
                }
                if tag == 8 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("6")
                    screen.label1.text = screen.inputString
                }
                if tag == 9 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("7")
                    screen.label1.text = screen.inputString
                }
                if tag == 10 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("8")
                    screen.label1.text = screen.inputString
                }
                if tag == 11 {
                    screen.backupString = screen.inputString
                    if screen.backupString.count > 0 {
                        if screen.figureArray.contains(screen.backupString.last!) {
                            while screen.figureArray.contains(screen.backupString.last!) {
                                screen.backupString.remove(at: screen.backupString.index(before: screen.backupString.endIndex))
                                numberCount += 1
                                if screen.backupString.first == nil {
                                    break
                                }
                            }
                            if numberCount >= 5 {
                                screen.backupString = ""
                                numberCount = 0
                                return
                            }
                        }
                    }
                    numberCount = 0
                    screen.backupString = ""
                    screen.inputString.append("9")
                    screen.label1.text = screen.inputString
                }
                if tag == 12 {
                    if screen.inputString.count > 0 {
                        screen.backupString2 = screen.inputString
                        while screen.backupString2.last != nil && (screen.figureArray.contains(screen.backupString2.last!) || screen.backupString2.last! == ".") {
                            screen.backupString2.remove(at: screen.backupString2.index(before: screen.backupString2.endIndex))
                            if screen.backupString2.count > 0 {
                                if screen.backupString2.last! == "/" {
                                    return
                                }
                            }
                        }
                        screen.backupString2 = ""
                        if screen.figureArray.contains(screen.inputString.last!) {
                            screen.inputString.append("/")
                            screen.label1.text = screen.inputString
                        }
                        else {
                            return
                        }
                    }
                }
                if tag == 15 {
                    if screen.firstLineColumn == 6 && screen.row == 1 {
                        return
                    }
                    if screen.inputString.count > 0 {
                        if screen.inputString.last! == "." {
                            screen.inputString.append("0")
                            screen.label1.text = screen.inputString
                        }
                        if screen.inputString.last! == "/" {
                            screen.inputString.append("1")
                            screen.label1.text = screen.inputString
                        }
                        if screen.figureArray.contains(screen.inputString.last!) {
                            if screen.row != 1 && screen.column == screen.firstLineColumn {
                                return
                            }
                            screen.inputString.append("   ")
                            screen.label1.text = screen.inputString
                            if screen.row == 1 {
                                screen.firstLineColumn += 1
                            }
                            else {
                                screen.column += 1
                            }
                        }
                    }
                }
            }
            if screen.row <= 5 {
                if tag == 16 {
                    if screen.inputString.count > 0 {
                        if screen.inputString.last! != " " {
                            if (screen.row == 1 || screen.column == screen.firstLineColumn) && screen.inputString.last! != "\n" {
                                if screen.inputString.last! != "." && screen.inputString.last! != "-" && screen.inputString.last! != "/" {
                                    screen.inputString.append("\n")
                                    screen.label1.text = screen.inputString
                                    screen.row += 1
                                    screen.column = 1
                                }
                                else {
                                    if screen.inputString.last! == "/" {
                                        screen.inputString.append("1")
                                        screen.inputString.append("\n")
                                        screen.label1.text = screen.inputString
                                        screen.row += 1
                                        screen.column = 1
                                    }
                                    else {
                                        screen.inputString.append("0")
                                        screen.inputString.append("\n")
                                        screen.label1.text = screen.inputString
                                        screen.row += 1
                                        screen.column = 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if tag == 14 {
                screen.deleteInput()
            }
            if tag == 13 {
                if screen.inputString == "" {
                    return
                }
                if screen.row != 1 {
                    if screen.column != screen.firstLineColumn {
                        if screen.figureArray.contains(screen.inputString.last!) || screen.inputString.last! == "." || screen.inputString.last! == "/" {
                            if screen.inputString.last! == "." {
                                screen.inputString.append("0")
                                screen.label1.text = screen.inputString
                            }
                            else if screen.inputString.last! == "/" {
                                screen.inputString.append("1")
                                screen.label1.text = screen.inputString
                            }
                            while screen.column != screen.firstLineColumn {
                                screen.inputString.append("   0")
                                screen.label1.text = screen.inputString
                                screen.column += 1
                            }
                        }
                        else {
                            while screen.column != screen.firstLineColumn + 1{
                                screen.inputString.append("0   ")
                                screen.label1.text = screen.inputString
                                screen.column += 1
                            }
                            screen.column -= 1
                            while screen.inputString.last! == " " {
                                screen.inputString.remove(at: screen.inputString.index(before: screen.inputString.endIndex))
                            }
                        }
                    }
                    else if screen.inputString.last! == " " {
                        screen.inputString.append("0")
                        screen.label1.text = screen.inputString
                    }
                    else if screen.inputString.last! == "\n" {
                        screen.inputString.remove(at: screen.inputString.index(before: screen.inputString.endIndex))
                        screen.row -= 1
                    }
                    else if screen.inputString.last! == "-" || screen.inputString.last! == "." || screen.inputString.last! == "/" {
                        if screen.inputString.last! == "-" || screen.inputString.last! == "." {
                            screen.inputString.append("0")
                            screen.label1.text = screen.inputString
                        }
                        else {
                            screen.inputString.append("1")
                            screen.label1.text = screen.inputString
                        }
                    }
                }
                else {
                    if screen.inputString.last! == " " {
                        while screen.inputString.last! == " " {
                            screen.inputString.remove(at: screen.inputString.index(before: screen.inputString.endIndex))
                        }
                        screen.firstLineColumn -= 1
                    }
                    else if screen.inputString.last! == "-" {
                        screen.inputString.append("0")
                    }
                    else if screen.inputString.last! == "/" {
                        screen.inputString.append("1")
                    }
                }
                if screen.row == 1 && screen.firstLineColumn == 1 {
                    if screen.inputString.last! == "." {
                        screen.inputString.append("0")
                    }
                    screen.label1.text = screen.inputString
                    screen.label2.text = "J(A) = "
                    check = false
                }
                else if screen.row == screen.firstLineColumn {
                    calculate.createMatrixA(screen.inputString, screen.row, screen.firstLineColumn)
                    if calculate.A.rank() != calculate.A.rows {
                        screen.label1.textColor = UIColor.red
                        screen.label1.text = "本App只能为可逆矩阵求Jordan标准型哦～！"
                    }
                    else {
                        screen.inputString = calculate.Jordan()
                        if screen.inputString == "本App只能为特征值均为整数的矩阵求Jordan标准型哦～！" {
                            screen.label1.textColor = UIColor.red
                            screen.label1.text = screen.inputString
                        }
                        else {
                            screen.label2.text = "J(A) = "
                            screen.label1.text = screen.inputString
                        }
                    }
                    check = false
                }
                else {
                    screen.label1.textColor = UIColor.red
                    screen.label1.text = "只有方阵才可以求Jordan标准型哦～！"
                    check = false
                }
            }
        }
        else {
            screen.clearScreen()
            screen.label1.textColor = UIColor.white
            calculate.inputString = ""
            check = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
