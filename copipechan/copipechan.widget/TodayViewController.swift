//
//  TodayViewController.swift
//  copipechan.widget
//
//  Created by yatemmma on 2015/02/01.
//  Copyright (c) 2015年 yatemmma. All rights reserved.
//

import UIKit
import NotificationCenter
//import <MobileCoreServices/UTCoreTypes.h>
import MobileCoreServices

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var widgetTableView: UITableView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.widgetTableView.delegate = self
        self.widgetTableView.dataSource = self
        self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, 2 * 44.0)
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(2)
        return 2;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell;
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = "hogehoge\(indexPath.row)"
        cell?.textLabel?.textColor = UIColor.whiteColor()
        
        return cell!;
    }

    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)")
        
        var board = UIPasteboard.generalPasteboard()
        board.setValue("fugafuga", forPasteboardType: kUTTypeUTF8PlainText)
        
//        UIPasteboard *board = [UIPasteboard generalPasteboard];
//        NSArray *textList = [[TextManager sharedManager] allText];
//        [board setValue:textList[indexPath.row] forPasteboardType:(NSString *)kUTTypeUTF8PlainText];
        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.textLabel.text = @"copied to clipboard.";
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        cell.textLabel.text = textList[indexPath.row];
//        });
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
