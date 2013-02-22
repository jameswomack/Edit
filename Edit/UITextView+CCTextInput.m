//
//  UITextView+CCTextInput.m
//  Edit
//
//  Created by James Womack on 2/21/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import "UITextView+CCTextInput.h"

@implementation UITextView (CCTextInput)


- (NSRange)safeRange
{
    NSRange range = self.selectedRange;
    
    if (range.location == NSNotFound)
        range.location = 0;
    
    return range;
}


- (void)setAttributedText:(NSAttributedString *)attributedText selectedRange:(NSRange)selectedRange
{
    self.attributedText = attributedText;
    self.selectedRange = selectedRange;
}


@end
