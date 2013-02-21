//
//  UITableViewCell+CCAttributedStringDescriptor.m
//  Edit
//
//  Created by James Womack on 2/21/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import "UITableViewCell+CCAttributedStringDescriptor.h"

@implementation UITableViewCell (CCAttributedStringDescriptor)

- (void)displayForAttributedString:(NSAttributedString*)attributedString withFontName:(NSString*)fontName andRange:(NSRange)range andIndexPath:(NSIndexPath*)indexPath
{
    NSAttributedString* attributedTextSubstring = [attributedString attributedSubstringFromRange:range];
    self.textLabel.text = attributedTextSubstring.string;
    
    NSRange rangeToPointTo = range;
    UIFont* font = [attributedString attribute:NSFontAttributeName atIndex:range.location effectiveRange:&rangeToPointTo];
    self.textLabel.font = [UIFont fontWithName:fontName size:font.pointSize];
}

@end
