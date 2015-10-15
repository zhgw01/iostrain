//
//  ExpandableTableViewCell.swift
//  LoadMoreTableViewCell
//
//  Created by zhanggongwei on 15/10/14.
//  Copyright © 2015年 cfs. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {

    typealias ExpandClosure = () -> Void
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var expandBlock: ExpandClosure?
    
    var expanded: Bool = true {
        didSet {
            let title = expanded ? "Collapse" : "Show";
            button.setTitle(title, forState: .Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onExpand(sender: AnyObject) {
        expanded = !expanded;
        
        if expandBlock != nil {
            expandBlock!()
        }
    }
}
