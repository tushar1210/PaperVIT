//
//  PageViewController.swift
//  Paper
//
//  Created by Tushar Singh on 10/12/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
    lazy var orderedVC: [UIViewController]={
        return [self.newVC(vc: "1"),
                self.newVC(vc: "2"),
                self.newVC(vc: "3")]
    }()
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstVC = orderedVC.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        self.delegate = self
        configureUIPageControll()
    }
    
    func newVC(vc:String)-> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vc )
    }
   

    func configureUIPageControll(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY-50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedVC.count
        pageControl.currentPage = 0
        
        pageControl.currentPageIndicatorTintColor = UIColor(red: 55/255, green: 67/255, blue: 77/255, alpha: 1)
        pageControl.tintColor = UIColor(red: 55/255, green: 67/255, blue: 77/255, alpha: 1)
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.gray
        self.view.addSubview(pageControl)
        
        }
    
}



extension PageViewController{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentVC = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedVC.index(of: pageContentVC)!
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedVC.index(of: viewController)
        else {
                return nil
        }
        let previousIndex = vcIndex-1
        
        guard previousIndex >= 0 else{
            return nil
        }
        guard orderedVC.count>previousIndex else{
            return nil
        }
        return orderedVC[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedVC.index(of: viewController)
            else {
                return nil
        }
        let nextIndex = vcIndex+1
        
        guard orderedVC.count != nextIndex else{
            return nil
        }
        guard orderedVC.count>nextIndex else{
            return nil
        }
        return orderedVC[nextIndex]
    }
}

