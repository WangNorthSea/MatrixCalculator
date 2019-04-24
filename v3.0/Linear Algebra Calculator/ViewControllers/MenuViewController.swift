//
//  MenuViewController.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/10.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let transition = PopAnimator()
    let layout = UICollectionViewFlowLayout()
    let layout2 = UICollectionViewFlowLayout()
    var collectionView:UICollectionView?
    let imageView0 = UIImageView(image: UIImage(named: "Item0"))
    let imageView1 = UIImageView(image: UIImage(named: "Item1"))
    let imageView2 = UIImageView(image: UIImage(named: "Item2"))
    let imageView3 = UIImageView(image: UIImage(named: "Item3"))
    let imageView4 = UIImageView(image: UIImage(named: "Item4"))
    let imageView5 = UIImageView(image: UIImage(named: "Item5"))
    let imageView6 = UIImageView(image: UIImage(named: "Item6"))
    let imageView7 = UIImageView(image: UIImage(named: "Item7"))
    let imageView8 = UIImageView(image: UIImage(named: "Item8"))
    let imageView9 = UIImageView(image: UIImage(named: "Item9"))
    let imageView10 = UIImageView(image: UIImage(named: "Item10"))
    let imageView11 = UIImageView(image: UIImage(named: "Item11"))
    let imageView12 = UIImageView(image: UIImage(named: "Item12"))
    let imageView13 = UIImageView(image: UIImage(named: "Item13"))
    let imageView14 = UIImageView(image: UIImage(named: "Item14"))
    let imageView15 = UIImageView(image: UIImage(named: "Item15"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.showsVerticalScrollIndicator = false
        layout.scrollDirection = .vertical
        layout.scrollDirection = .vertical
        
        collectionView?.backgroundColor = UIColor(red: 81 / 255, green: 172 / 255, blue: 235 / 255, alpha: 1)
        self.view.addSubview(collectionView!)
        layout.itemSize = CGSize(width:(collectionView?.superview!.frame.width)! - 150, height:60)
        layout.minimumLineSpacing = 35
        layout.sectionInset = UIEdgeInsets(top:70, left:200, bottom:70, right:0)
        layout2.itemSize = CGSize(width:(collectionView?.superview!.frame.width)! - 150, height:60)
        layout2.minimumLineSpacing = 35
        layout2.sectionInset = UIEdgeInsets(top:70, left:0, bottom:70, right:0)
        
        imageView0.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView1.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView2.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView3.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView4.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView5.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView6.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView7.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView8.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView9.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView10.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView11.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView12.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView13.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView14.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        imageView15.frame = CGRect(x:0, y:0, width:(collectionView?.superview!.frame.width)! - 150, height: 60)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(NSClassFromString("UICollectionViewCell"), forCellWithReuseIdentifier: "itemId")
        
        Thread.sleep(forTimeInterval: 0.7)
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView?.setCollectionViewLayout(layout2, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemId", for: indexPath)
        if indexPath.row == 0 {
            cell.addSubview(imageView0)
        }
        if indexPath.row == 1 {
            cell.addSubview(imageView1)
        }
        if indexPath.row == 2 {
            cell.addSubview(imageView2)
        }
        if indexPath.row == 3 {
            cell.addSubview(imageView3)
        }
        if indexPath.row == 4 {
            cell.addSubview(imageView4)
        }
        if indexPath.row == 5 {
            cell.addSubview(imageView5)
        }
        if indexPath.row == 6 {
            cell.addSubview(imageView6)
        }
        if indexPath.row == 7 {
            cell.addSubview(imageView7)
        }
        if indexPath.row == 8 {
            cell.addSubview(imageView8)
        }
        if indexPath.row == 9 {
            cell.addSubview(imageView9)
        }
        if indexPath.row == 10 {
            cell.addSubview(imageView10)
        }
        if indexPath.row == 11 {
            cell.addSubview(imageView11)
        }
        if indexPath.row == 12 {
            cell.addSubview(imageView12)
        }
        if indexPath.row == 13 {
            cell.addSubview(imageView13)
        }
        if indexPath.row == 14 {
            cell.addSubview(imageView14)
        }
        if indexPath.row == 15 {
            cell.addSubview(imageView15)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let transposeViewController = TransposeViewController()
            transposeViewController.transitioningDelegate = self
            self.present(transposeViewController, animated: true, completion: nil)
        }
        if indexPath.row == 1 {
            let inverseViewController = InverseViewController()
            inverseViewController.transitioningDelegate = self
            self.present(inverseViewController, animated: true, completion: nil)
        }
        if indexPath.row == 2 {
            let minimalPolynomialViewController = MinimalPolynomialViewController()
            minimalPolynomialViewController.transitioningDelegate = self
            self.present(minimalPolynomialViewController, animated: true, completion: nil)
        }
        if indexPath.row == 3 {
            let eigenValueViewController = EigenvalueViewController()
            eigenValueViewController.transitioningDelegate = self
            self.present(eigenValueViewController, animated: true, completion: nil)
        }
        if indexPath.row == 4 {
            let jordanViewController = JordanViewController()
            jordanViewController.transitioningDelegate = self
            self.present(jordanViewController, animated: true, completion: nil)
        }
        if indexPath.row == 5 {
            let determinantViewController = DeterminantViewController()
            determinantViewController.transitioningDelegate = self
            self.present(determinantViewController, animated: true, completion: nil)
        }
        if indexPath.row == 6 {
            let rankViewController = RankViewController()
            rankViewController.transitioningDelegate = self
            self.present(rankViewController, animated: true, completion: nil)
        }
        if indexPath.row == 7 {
            let adjointViewController = AdjointViewController()
            adjointViewController.transitioningDelegate = self
            self.present(adjointViewController, animated: true, completion: nil)
        }
        if indexPath.row == 8 {
            let multiplicationViewController = MultiplicationViewController()
            multiplicationViewController.transitioningDelegate = self
            self.present(multiplicationViewController, animated: true, completion: nil)
        }
        if indexPath.row == 9 {
            let additionViewController = AdditionViewController()
            additionViewController.transitioningDelegate = self
            self.present(additionViewController, animated: true, completion: nil)
        }
        if indexPath.row == 10 {
            let subtractionViewController = SubtractionViewController()
            subtractionViewController.transitioningDelegate = self
            self.present(subtractionViewController, animated: true, completion: nil)
        }
        if indexPath.row == 11 {
            let linearEquationsViewController = LinearEquationsViewController()
            linearEquationsViewController.transitioningDelegate = self
            self.present(linearEquationsViewController, animated: true, completion: nil)
        }
        if indexPath.row == 12 {
            let qRdecompositionViewController = QRdecompositionViewController()
            qRdecompositionViewController.transitioningDelegate = self
            self.present(qRdecompositionViewController, animated: true, completion: nil)
        }
        if indexPath.row == 13 {
            let hessenbergViewController = HessenbergViewController()
            hessenbergViewController.transitioningDelegate = self
            self.present(hessenbergViewController, animated: true, completion: nil)
        }
        if indexPath.row == 14 {
            let traceViewController = TraceViewController()
            traceViewController.transitioningDelegate = self
            self.present(traceViewController, animated: true, completion: nil)
        }
        if indexPath.row == 15 {
            let informationViewController = InformationViewController()
            informationViewController.transitioningDelegate = self
            self.present(informationViewController, animated: true, completion: nil)
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuViewController: UIViewControllerTransitioningDelegate {
    
}
