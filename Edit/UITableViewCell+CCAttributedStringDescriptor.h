//
//  UITableViewCell+CCAttributedStringDescriptor.h
//  Edit
//
//  Created by James Womack on 2/21/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CCAttributedStringDescriptor)

- (void)displayForAttributedString:(NSAttributedString*)attributedString withFontName:(NSString*)fontName andRange:(NSRange)range andIndexPath:(NSIndexPath*)indexPath;

@end
