//
//  TextViewController.m
//  copipechan
//
//  Created by yatemmma on 2014/12/04.
//  Copyright (c) 2014年 yatemmma. All rights reserved.
//

#import "TextViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>
#import "TextManager.h"

@interface TextViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *textList;

@end

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[TextManager sharedManager] allText].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    NSArray *textList = [[TextManager sharedManager] allText];
    cell.textLabel.text = textList[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    NSArray *textList = [[TextManager sharedManager] allText];
    [board setValue:textList[indexPath.row] forPasteboardType:(NSString *)kUTTypeUTF8PlainText];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = @"copied to clipboard.";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.textLabel.text = textList[indexPath.row];
    });
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Detail and Delete view.
    NSArray *textList = [[TextManager sharedManager] allText];
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:textList[indexPath.row]
                                                     message:[NSString stringWithFormat:@"%d", indexPath.row]
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Delete", nil];
    [dialog show];
}

#pragma mark - Touche Events
- (IBAction)addButtonTouched:(id)sender
{
    [self showInputDialog];
}

#pragma mark - Input Dialog
- (void)showInputDialog
{
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"Enter new text"
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // Cancel
        return;
    }
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
        // Add
        [[TextManager sharedManager] addText:[alertView textFieldAtIndex:0].text];
    } else {
        // Delete
        
    }
    [self.tableView reloadData];
}
@end
