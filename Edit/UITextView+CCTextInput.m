//
//  UITextView+CCTextInput.m
//  Edit
//
//  Created by James Womack on 2/21/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//


#import "UITextView+CCTextInput.h"



@implementation UITextView (CCTextInput)


+ (void)initialize
{
    unsigned selectorCount = 2;
    SEL *selectors = (SEL*)malloc( sizeof(SEL)*selectorCount );
    selectors[0] = @selector(becomeFirstResponder);
    selectors[1] = @selector(resignFirstResponder);
    
    while (selectorCount--)
    {
        NSString *selectorString = NSStringFromSelector(selectors[selectorCount]);
        
        NSString *supplementarySelectorString = [@"swizzled_" stringByAppendingString:selectorString];
        
        SEL supplementarySelector = NSSelectorFromString(supplementarySelectorString);
        
        [self swapInstanceSelector:selectors[selectorCount] withSelector:supplementarySelector];
    }
}


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


- (BOOL)swizzled_becomeFirstResponder
{
    self.editable = YES;
    return [self swizzled_becomeFirstResponder];
}


- (BOOL)swizzled_resignFirstResponder
{
    self.editable = NO;
    return [self swizzled_resignFirstResponder];
}



@end
