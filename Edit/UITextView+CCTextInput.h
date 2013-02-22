//
//  UITextView+CCTextInput.h
//  Edit
//
//  Created by James Womack on 2/21/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (CCTextInput)

- (NSRange)safeRange;
- (void)setAttributedText:(NSAttributedString *)attributedText selectedRange:(NSRange)selectedRange;

@end
