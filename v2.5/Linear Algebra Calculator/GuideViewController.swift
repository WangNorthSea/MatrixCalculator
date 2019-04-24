//
//  GuideViewController.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/6/2.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import AudioToolbox

class GuideViewController: UIViewController, UIScrollViewDelegate {

    var numPages = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.bounds
        let scrollView = UIScrollView()
        
        scrollView.frame = self.view.bounds
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width:frame.size.width * CGFloat(numPages), height:frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        for i in 0..<numPages {
            
            let imgView = UIImageView(image: UIImage(named: "welcome\(i + 1)"))
            imgView.frame = CGRect(x:frame.size.width * CGFloat(i), y:0, width:frame.size.width, height: frame.size.height)
            scrollView.addSubview(imgView)
        }
        
        scrollView.contentOffset = CGPoint.zero
        self.view.addSubview(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = CGFloat(numPages - 1) * self.view.bounds.size.width
        
        if scrollView.contentOffset.x > width {
            AudioServicesPlaySystemSound(1520)
            let menuViewController = MenuViewController()
            self.present(menuViewController, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
