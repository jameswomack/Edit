//
//  CCViewController.h
//  Edit
//
//  Created by James Womack on 2/20/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCTableViewController;

@interface CCViewController : UIViewController <UITextViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet CCTableViewController *tableDelegate;
- (IBAction)tap:(UITapGestureRecognizer *)sender;

@end
