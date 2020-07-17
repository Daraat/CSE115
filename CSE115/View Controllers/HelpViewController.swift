//
//  HelpViewController.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 7/16/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var contentWidth:CGFloat = 0.0

    
    
    
   /* override func viewDidLoad() {
    super.viewDidLoad()
        scrollView.delegate = self
        for image in 0...2 {
            let imageToDispay  = UIImage(named: "\(image).png" )
            let imageView =  UIImageView(image:  imageToDispay)
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
            contentWidth += view.frame.width
            scrollView.addSubview(imageView)
            imageView.frame  = CGRect(x: xCoordinate - 50, y: (view.frame.height / 2) - 50, width: 200, height: 200)
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(414))
    }
     */ }

