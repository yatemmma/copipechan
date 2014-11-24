//
//  ViewController.swift
//  copipechan
//
//  Created by yatemmma on 2014/11/24.
//  Copyright (c) 2014 yatemmma. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let textList = ["あいうえお", "1234567890", "abcdefg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if (cell == nil) {
            cell =  UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        cell!.textLabel.text = textList[indexPath.row]
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text = textList[indexPath.row];
        let board: UIPasteboard = UIPasteboard.generalPasteboard()
        board.setValue(text, forPasteboardType:kUTTypeUTF8PlainText)
        
        // TODO: Use https://github.com/scalessec/toast from CocoaPods
    }
}

