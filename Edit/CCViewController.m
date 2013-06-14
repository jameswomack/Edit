//
//  CCViewController.m
//  Edit
//
//  Created by James Womack on 2/20/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//


#import "CCViewController.h"
#import "CCTableViewController.h"
#import "UITextView+CCTextInput.h"



@interface CCViewController ()
{
    UIFont* fontNew;
}
@end



@implementation CCViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSNotificationCenter.defaultCenter postNotificationName:CCTableViewReady object:self.tableView];
    
    [NSNotificationCenter.defaultCenter addObserverForName:CCFontSelected object:nil queue:NULL usingBlock:^(NSNotification *note) {
        NSUInteger safeRangeLength = self.textView.safeRange.length;
        BOOL inPlaceEditing = (safeRangeLength == 0);
        [self changeFontForTextViewWithFont:note.object inPlaceEditing:inPlaceEditing];
    }];
    
    [THBinder binderFromObject:self.textView keyPath:@"isFirstResponder" toObject:self.textView keyPath:@"editable"];
}


- (void)changeFontForTextViewWithFont:(UIFont*)aFont inPlaceEditing:(BOOL)inPlaceEditing
{
    NSRange rangePrior = self.textView.selectedRange;
    NSRange range = self.textView.safeRange;
    
    NSRange rangeToPointTo = NSMakeRange(0, 1);
    
    CGFloat pointSize = [[self.textView.attributedText attribute:NSFontAttributeName
                                                         atIndex:range.location
                                                  effectiveRange:&rangeToPointTo] pointSize];
    
    UIFont* font = [UIFont fontWithName:aFont.fontName size:pointSize];
    
    NSMutableAttributedString* attributedText = self.textView.attributedText.mutableCopy;
    
    [attributedText setAttributes:@{ NSFontAttributeName : font }
                            range:fontNew?NSMakeRange(range.location-1, 1):range];
    
    if (inPlaceEditing)
    {
        fontNew = font.copy;
    }
    else
    {
        [self.textView setAttributedText:attributedText selectedRange:rangePrior];
        fontNew = nil;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    fontNew ? [self changeFontForTextViewWithFont:fontNew inPlaceEditing:NO] : 0;
}


- (void)textViewDidChangeSelection:(UITextView *)textView
{
    // TODO - Author method that uses runtime (so-called swizzling in particular)
    // to post notifications when a certain method is called
    [NSNotificationCenter.defaultCenter postNotificationName:CCTextViewSelectionChanged object:self.textView];
}


- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    if (self.textView.isFirstResponder)
    {
        [self.textView resignFirstResponder];
        //self.textView.editable = NO;
    }
    else
    {
        [self.textView becomeFirstResponder];
        //self.textView.editable = YES;
    }
}


- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    __block CGRect tableViewFrame = self.tableView.frame;
    [UIView animateWithDuration:0.5f animations:^{
        if (self.tableView.alpha)
        {
            self.tableView.alpha = 0.f;
            tableViewFrame.origin.x = self.view.frame.size.width;
        }
        else
        {
            self.tableView.alpha = 0.8f;
            tableViewFrame.origin.x = self.view.frame.size.width/2;
        }
        self.tableView.frame = tableViewFrame;
    }];
}



@end
