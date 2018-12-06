//
//  Keyboard3.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/11/19.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit
import AudioToolbox

protocol Keyboard3ButtonClicked {
    func buttonClicked(tag:Int)
}

class Keyboard3: UIView {
    
    var dataArray = ["0", ".", "-", "1", "2", "3", "4", "5", "6", "7", "8", "9", "/", "计算", "删除", "完成", "前进", "下一行"]
    var delegate:Keyboard3ButtonClicked?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    func loadUI() {
        
        var frontBtn:Buttons!
        var exampleBtn:Buttons!
        var exampleBtn2:Buttons!
        
        for index in 0..<18 {
            let btn = Buttons()
            self.addSubview(btn)
            if index == 0 {
                btn.setImage(UIImage(named: "0"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "0Highlighted"), for: UIControlState.highlighted)
            }
            if index == 1 {
                btn.setImage(UIImage(named: "Point"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "PointHighlighted"), for: UIControlState.highlighted)
            }
            if index == 2 {
                btn.setImage(UIImage(named: "Minus"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "MinusHighlighted"), for: UIControlState.highlighted)
            }
            if index == 3 {
                btn.setImage(UIImage(named: "1"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "1Highlighted"), for: UIControlState.highlighted)
            }
            if index == 4 {
                btn.setImage(UIImage(named: "2"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "2Highlighted"), for: UIControlState.highlighted)
            }
            if index == 5 {
                btn.setImage(UIImage(named: "3"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "3Highlighted"), for: UIControlState.highlighted)
            }
            if index == 6 {
                btn.setImage(UIImage(named: "4"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "4Highlighted"), for: UIControlState.highlighted)
            }
            if index == 7 {
                btn.setImage(UIImage(named: "5"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "5Highlighted"), for: UIControlState.highlighted)
            }
            if index == 8 {
                btn.setImage(UIImage(named: "6"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "6Highlighted"), for: UIControlState.highlighted)
            }
            if index == 9 {
                btn.setImage(UIImage(named: "7"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "7Highlighted"), for: UIControlState.highlighted)
            }
            if index == 10 {
                btn.setImage(UIImage(named: "8"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "8Highlighted"), for: UIControlState.highlighted)
            }
            if index == 11 {
                btn.setImage(UIImage(named: "9"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "9Highlighted"), for: UIControlState.highlighted)
            }
            if index == 12 {
                btn.setImage(UIImage(named: "Div"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "DivHighlighted"), for: UIControlState.highlighted)
            }
            if index == 13 {
                btn.setImage(UIImage(named: "Calculate"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "CalculateHighlighted"), for: UIControlState.highlighted)
            }
            if index == 14 {
                btn.setImage(UIImage(named: "Delete"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "DeleteHighlighted"), for: UIControlState.highlighted)
            }
            if index == 15 {
                btn.setImage(UIImage(named: "Change"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "ChangeHighlighted"), for: UIControlState.highlighted)
            }
            if index == 16 {
                btn.setImage(UIImage(named: "Go2"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "Go2Highlighted"), for: UIControlState.highlighted)
            }
            if index == 17 {
                btn.setImage(UIImage(named: "NextRow"), for: UIControlState.normal)
                btn.setImage(UIImage(named: "NextRowHighlighted"), for: UIControlState.highlighted)
            }
            btn.snp.makeConstraints({(maker) in
                if index <= 11 {
                    if index == 0 || index % 3 == 0 {
                        maker.left.equalTo(0)
                    }
                    else {
                        maker.left.equalTo(frontBtn.snp.right)
                    }
                    if index == 0 || index == 1 || index == 2 {
                        maker.bottom.equalTo(0)
                        if index == 2 {
                            exampleBtn = btn
                        }
                    }
                    else if index % 3 == 0 {
                        maker.bottom.equalTo(frontBtn.snp.top)
                    }
                    else {
                        maker.bottom.equalTo(frontBtn.snp.bottom)
                        if index == 5 {
                            exampleBtn2 = btn
                        }
                    }
                    if index == 0 {
                        maker.width.equalTo(btn.superview!.snp.width).multipliedBy(0.25)
                    }
                    else {
                        maker.width.equalTo(btn.superview!.snp.width).multipliedBy(0.25)
                    }
                    maker.height.equalTo(btn.superview!.snp.height).multipliedBy(0.2)
                }
                else {
                    if index == 12 {
                        maker.bottom.equalTo(0)
                    }
                    else if index == 13 || index == 14  || index == 15 {
                        maker.bottom.equalTo(frontBtn.snp.top)
                    }
                    else {
                        maker.bottom.equalTo(frontBtn.snp.bottom)
                    }
                    if index == 12 || index == 13 || index == 14 {
                        maker.left.equalTo(exampleBtn.snp.right)
                        maker.width.equalTo(btn.superview!.snp.width).multipliedBy(0.25)
                        if index <= 13 {
                            maker.height.equalTo(btn.superview!.snp.height).multipliedBy(0.2)
                        }
                        else {
                            maker.height.equalTo(btn.superview!.snp.height).multipliedBy(0.4)
                        }
                    }
                    else if index == 15 || index == 16 {
                        maker.width.equalTo(btn.superview!.snp.width).multipliedBy(0.25)
                        maker.height.equalTo(btn.superview!.snp.height).multipliedBy(0.2)
                        if index == 15 {
                            maker.left.equalTo(exampleBtn2.snp.right)
                        }
                        else {
                            maker.right.equalTo(frontBtn.snp.left)
                        }
                    }
                    else {
                        maker.width.equalTo(btn.superview!.snp.width).multipliedBy(0.5)
                        maker.height.equalTo(btn.superview!.snp.height).multipliedBy(0.2)
                        maker.left.equalTo(0)
                    }
                }
            })
            btn.tag = index
            btn.addTarget(self, action: #selector(btnClick(button:)), for: UIControlEvents.touchDown)
            btn.addTarget(self, action: #selector(btnClicked(button:)), for: UIControlEvents.touchUpInside)
            frontBtn = btn
        }
    }
    
    @objc func btnClick(button:Buttons) {
        
        if button.tag >= 13 {
            AudioServicesPlaySystemSound(1520)
        }
    }
    
    @objc func btnClicked(button:Buttons) {
        
        if delegate != nil {
            delegate?.buttonClicked(tag: button.tag)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
