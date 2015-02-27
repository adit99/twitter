//
//  SideBar.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/26/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate {
    func sideBarDidSelectButtonAtIndex(index:Int)
    optional func sideBarWillClose()
    optional func sideBarWillOpen()
}

class SideBar: NSObject, SideBarTableViewControllerDelegate, UIGestureRecognizerDelegate {
   
    let barWidth:CGFloat = 150.0
    let sideBarTableViewTopInset:CGFloat = 64.0
    let sideBarContainerView:UIView = UIView()
    let sideBarTableViewController:SideBarTableViewController!
    let originView:UIView!
    let animator:UIDynamicAnimator!
    var delegate:SideBarDelegate?
    var isSideBarOpen:Bool = false
    
    //menu list
    
    override init() {
        super.init()
    }
    
    init(sourceView:UIView, menu:Array<String>) {
        super.init()
        
        originView = sourceView
        sideBarTableViewController = SideBarTableViewController()
        sideBarTableViewController.tableData = menu
        
        setupSideBar()
        
        animator = UIDynamicAnimator(referenceView: originView)
    
        let showGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        originView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        originView.addGestureRecognizer(hideGestureRecognizer)
        
    }
    
    func setupSideBar() {
        sideBarContainerView.frame = CGRectMake(-barWidth-1, originView.frame.origin.y, barWidth, originView.frame.size.height)
        sideBarContainerView.clipsToBounds = false
        sideBarContainerView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.8)
        originView.addSubview(sideBarContainerView)
        
        
        let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blurView.frame = sideBarContainerView.frame
        sideBarContainerView.addSubview(blurView)
        
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sideBarTableViewController.tableView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.8)
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsetsMake(sideBarTableViewTopInset, 0, 0, 0)
        
        sideBarTableViewController.tableView.reloadData()
        
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
    }
    
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        println("handle swipe")
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left {
            //hide
            showSideBar(false)
            self.delegate?.sideBarWillClose?()
        } else {
            showSideBar(true)
            self.delegate?.sideBarWillClose?()
        }
    }
    
    func showSideBar(shouldOpen:Bool) {
        println("show side bar")
        //animating
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        
        let gravityX:CGFloat = (shouldOpen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shouldOpen) ? 20 : -20
        let boundaryX:CGFloat = (shouldOpen) ? barWidth : -barWidth - 1
        
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehavior.gravityDirection = CGVectorMake(gravityX, 0)
        animator.addBehavior(gravityBehavior)

        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehavior.addBoundaryWithIdentifier("sideBarBoundary", fromPoint: CGPointMake(boundaryX, 20), toPoint: CGPointMake(boundaryX, originView.frame.size.height))
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.Instantaneous)
        animator.addBehavior(pushBehavior)
        
        let sideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
        
    }
    
    func sideBarDidSelectRow(indexPath: NSIndexPath) {
        println("side bar selected button")
        delegate?.sideBarDidSelectButtonAtIndex(indexPath.row)
    }
    
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        println("should begin")
        return true
    }
}
