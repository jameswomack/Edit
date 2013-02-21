//
//  CCViewController.m
//  Edit
//
//  Created by James Womack on 2/20/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import "CCViewController.h"
#import "CCTableViewController.h"
@interface CCViewController ()
{
    UIFont* fontNew;
}
@end

@implementation CCViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"CCTableViewReady" object:self.tableView];
    
    [NSNotificationCenter.defaultCenter addObserverForName:@"CCFontSelected" object:nil queue:NULL usingBlock:^(NSNotification *note) {        
        [self changeFontForTextViewWithFont:note.object inPlaceEditing:(self.safeRange.length == 0)];
    }];
}


- (NSRange)safeRange
{
    NSRange range = self.textView.selectedRange;
    
    if (range.location == NSNotFound) //NSNotFound == 2147483647, the 8th Mersenne prime
        range = NSMakeRange(0, self.textView.attributedText.string.length-1);
    
    return range;
}


- (void)changeFontForTextViewWithFont:(UIFont*)aFont inPlaceEditing:(BOOL)inPlaceEditing
{
    NSRange rangePrior = self.textView.selectedRange;
    NSRange range = self.safeRange;
    
    NSRange rangeToPointTo = NSMakeRange(0, 1);
    
    CGFloat pointSize = [[self.textView.attributedText attribute:NSFontAttributeName atIndex:range.location effectiveRange:&rangeToPointTo] pointSize];
    
    UIFont* font = [UIFont fontWithName:aFont.fontName size:pointSize];
    
    NSMutableAttributedString* attributedText = self.textView.attributedText.mutableCopy;
    
    if (fontNew)
        [attributedText setAttributes:@{ NSFontAttributeName : font } range:NSMakeRange(range.location-1, 1)];
    else
        [attributedText setAttributes:@{ NSFontAttributeName : font } range:range];
    
    if (inPlaceEditing)
    {
        fontNew = font.copy;
    }
    else
    {
        self.textView.attributedText = attributedText;
        self.textView.selectedRange = rangePrior;
        fontNew = nil;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (fontNew)
    {
        [self changeFontForTextViewWithFont:fontNew inPlaceEditing:NO];
    }
}


- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [NSNotificationCenter.defaultCenter postNotificationName:@"CCTextViewSelectionChanged" object:self.textView];
}


- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    if (self.textView.isFirstResponder)
    {
        [self.textView resignFirstResponder];
        self.textView.editable = NO;
    }
    else
    {
        [self.textView becomeFirstResponder];
        self.textView.editable = YES;
    }
}


- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.5f animations:^{
        if (self.tableView.alpha)
        {
            self.tableView.alpha = 0.f;
            self.tableView.frame = CGRectMake(self.view.frame.size.width, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        }
        else
        {
            self.tableView.alpha = 0.8f;
            self.tableView.frame = CGRectMake(self.view.frame.size.width/2, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        }
    }];
}



@end
