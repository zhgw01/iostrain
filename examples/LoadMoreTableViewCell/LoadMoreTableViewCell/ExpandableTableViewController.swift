//
//  ExpandableTableViewController.swift
//  LoadMoreTableViewCell
//
//  Created by zhanggongwei on 15/10/14.
//  Copyright © 2015年 cfs. All rights reserved.
//

import UIKit

class ExpandableTableViewController: UITableViewController {
    
    let datasources : [String]  = ["The first step to creating a fancy animation was creating a UITableViewCell (called BookCell) with flexible constraints. By flexible, I mean that no constraint was absolutely required. The cell included a yellow subview subview with a collapsible height constraint — the height constraint always has a constant of 0, and it initially has a priority of 999. Within the collapsible subview, no vertical constraints are required. We set the priority of all the internal vertical constraints to 998.","用人单位法定节假日安排加班，应按不低于日或者小时工资基数的300％支付加班工资，休息日期间安排加班，应当安排同等时间补休，不能安排补休的，按照不低于日或者小时工资基数的200％支付加班工资。","如《广东省工资支付条例》第三十五 条非因劳动者原因造成用人单位停工、停产，未超过一个工资支付周期（最长三十日）的，用人单位应当按照正常工作时间支付工资。超过一个工资支付周期的，可以根据劳动者提供的劳动，按照双方新约定的标准支付工资；用人单位没有安排劳动者工作的，应当按照不低于当地最低工资标准的百分之八十支付劳动者生活费，生活费发放至企业复工、复产或者解除劳动关系。","来看看劳动法克林顿刷卡思考对方卡拉卡斯的楼房卡拉卡斯的疯狂拉萨的罚款 ","中秋节、十一假期分为两类。一类是法定节假日，即9月30日(中秋节)、10月1日、2日、3日共四天为法定节假日;另一类是休息日，即10月4日至10月7日为休息日。","2000(元)÷21.75(天)×200％×1(天)=183.9(元)"]
    
    var expandedIndexPath:Set<NSIndexPath> = Set<NSIndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasources.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExpandableTableViewCellIndenfier", forIndexPath: indexPath) as! ExpandableTableViewCell

        // Configure the cell...
        cell.label.text = self.datasources[indexPath.row]
        
        let textHeight = cell.label.sizeThatFits(CGSizeMake(tableView.bounds.size.width, 9999)).height;
        
        if (textHeight > 80) {
            cell.button.hidden = false
            cell.expanded = expandedIndexPath.contains(indexPath)
            cell.expandBlock = {
                if cell.expanded {
                    self.expandedIndexPath.insert(indexPath)
                } else {
                    self.expandedIndexPath.remove(indexPath)
                }
                
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            
        } else {
            cell.button.hidden = true
        }
        

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.expandedIndexPath.contains(indexPath) {
            return 240;
        } else {
            return 120;
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
