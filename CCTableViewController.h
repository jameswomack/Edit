//
//  CCTableViewController.h
//  Edit
//
//  Created by James Womack on 2/20/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTableViewController : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (strong) NSAttributedString* attributedText;
@property NSUInteger index;
@property NSRange range;
@end
