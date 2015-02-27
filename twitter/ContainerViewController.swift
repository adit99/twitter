//
//  ContainerViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/24/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var sideBar : SideBar?
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        println("side bar did select")
    }    
    
}
