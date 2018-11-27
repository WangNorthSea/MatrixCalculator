//
//  SavedMatrices.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/6/11.
//  Copyright © 2018 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit

protocol SavedMatricesDelegate {
    func didSelectRow(_ string: String)
}

class SavedMatrices: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let label = UILabel()
    var tableView = UITableView()
    let edit = UIButton()
    let back = UIButton()
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    var path: String = ""
    var contentsOfPath: [String] = []
    let fileManager = FileManager()
    var matrixSaved: [String] = []
    var delegate: SavedMatricesDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    
    func loadUI() {
        
        self.addSubview(label)
        self.addSubview(edit)
        self.addSubview(back)
        
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.text = "已存矩阵"
        label.textAlignment = NSTextAlignment.center
        
        label.snp.makeConstraints({(maker) in
            maker.top.left.right.equalTo(0)
            maker.height.equalTo(50)
        })
        
        edit.setTitle("编辑", for: UIControlState.normal)
        back.setTitle("返回", for: UIControlState.normal)
        edit.setTitleColor(UIColor.white, for: UIControlState.normal)
        edit.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        back.setTitleColor(UIColor.white, for: UIControlState.normal)
        back.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        back.addTarget(self, action: #selector(Back), for: .touchUpInside)
        edit.addTarget(self, action: #selector(Edit), for: .touchUpInside)
        
        edit.snp.makeConstraints({(maker) in
            maker.top.equalTo(10)
            maker.right.equalTo(-10)
            maker.height.equalTo(30)
            maker.width.equalTo(40)
        })
        
        back.snp.makeConstraints({(maker) in
            maker.top.left.equalTo(10)
            maker.height.equalTo(30)
            maker.width.equalTo(40)
        })
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints({(maker) in
            maker.left.equalTo(0)
            maker.top.equalTo(50)
            maker.height.equalTo(tableView.superview!.snp.height)
            maker.width.equalTo(tableView.superview!.snp.width)
        })
        
        tableView.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1)
        tableView.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "TableViewCellId")
        
        path = paths[0]
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func Back() {
        self.alpha = 1
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {self.alpha = 0}, completion: nil)
    }
    
    @objc func Edit() {
        if edit.titleLabel?.text == "编辑" {
            tableView.isEditing = true
            edit.setTitle("完成", for: UIControlState.normal)
        }
        else {
            tableView.isEditing = false
            edit.setTitle("编辑", for: UIControlState.normal)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if delegate != nil {
            delegate?.didSelectRow((tableView.cellForRow(at: indexPath)?.textLabel?.text)!)
        }
        self.alpha = 1
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {self.alpha = 0}, completion: nil)
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentsOfPath = try! fileManager.contentsOfDirectory(atPath: path)
        matrixSaved = []
        for i in 0..<contentsOfPath.count {
            matrixSaved.append(contentsOfPath[i])
            for _ in 1...6 {
                matrixSaved[i].remove(at: matrixSaved[i].index(before: matrixSaved[i].endIndex))
            }
        }
        return contentsOfPath.count
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            try! fileManager.removeItem(atPath: path + "/\((tableView.cellForRow(at: indexPath)?.textLabel?.text)!).plist")
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath)
        cell.textLabel?.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1)
        cell.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        for i in 0..<contentsOfPath.count {
            if indexPath.row == i {
                cell.textLabel?.text = matrixSaved[i]
            }
        }
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
