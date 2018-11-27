//
//  InformationViewController.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/6/10.
//  Copyright © 2018 UCAS Developers. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
    var dataArray:[String]?
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = ["评价本App", "作者的话"]
        let width = self.view.frame.width
        let height = self.view.frame.height - 62
        let back = UIButton()
        let tableView = UITableView(frame: CGRect(x: 0, y: 62, width: width, height: height), style: .grouped)
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(click))
        let view = InformationScreen()
        
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.6)
        tableView.backgroundColor = UIColor(red: 67 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1)
        tableView.register(UINib.init(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCellId")
        tableView.tableHeaderView = view
        
        back.frame = CGRect(x:10, y:30, width:65, height:32)
        back.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        back.setImage(UIImage(named: "BackHighlighted"), for: UIControlState.highlighted)
        back.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        self.view.addSubview(back)
        self.view.addGestureRecognizer(swip)
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor(red: 67 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func click() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0, 0] {
            let urlString = "itms-apps://itunes.apple.com/app/id1399895778"
            let url = URL(string: urlString)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        else {
            let developerViewController = DeveloperViewController()
            developerViewController.transitioningDelegate = self
            self.present(developerViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let string = " Copyright © 2018  Haoyu Wang\n University of Chinese Academy of Sciences\n App Icon provided by Xim\n v2.6"
        if section == 0 {
            return ""
        }
        else {
            return string
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath) as! NewTableViewCell
        cell.textLabel?.text = dataArray?[indexPath.section]
        cell.backgroundColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        cell.textLabel?.backgroundColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = CGRect(x: self.view.frame.maxX - 1, y:0, width: 1, height: self.view.frame.height)
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
