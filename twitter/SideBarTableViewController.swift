//
//  SideBarTableViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/26/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

protocol SideBarTableViewControllerDelegate {
    func sideBarDidSelectRow(indexPath: NSIndexPath)
}

class SideBarTableViewController: UITableViewController {

    var delegate: SideBarTableViewControllerDelegate?
    var tableData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("view did load stvc" )
       
        //register the sidebar cell
        let nib = UINib(nibName: "SideBarCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: "SideBarCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println("number of row: \(tableData.count)")
        return tableData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("cell for row sidebar controller")
        //var cell = tableView.dequeueReusableCellWithIdentifier("SideBarCell", forIndexPath: indexPath) as SideBarCell

        var cell = UITableViewCell()
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.textColor = UIColor(CIColor: CIColor(red: 85/255, green: 172/255, blue: 238/255))

        let selectedView:UIView = UIView(frame: CGRect(x:0, y:0, width: cell.frame.size.width, height: cell.frame.size.height))
        selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            
        cell.selectedBackgroundView = selectedView
        cell.textLabel!.text = tableData[indexPath.row]
        cell.textLabel!
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.sideBarDidSelectRow(indexPath)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
