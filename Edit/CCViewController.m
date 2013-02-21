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

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//NSRange range = [self.textView selectedRange];
    //- (void)setAttributes:(NSDictionary *)attributes range:(NSRange)aRange
    /*
     NSArray *familyNames = [UIFont familyNames];
     
     for( NSString *familyName in familyNames ){
     printf( "Family: %s \n", [familyName UTF8String] );
     
     NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
     for( NSString *fontName in fontNames ){
     printf( "\tFont: %s \n", [fontName UTF8String] );
     
     }
     }          
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
     paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
     paragraphStyle.alignment = NSTextAlignmentLeft;
     NSAttributedString *string
     = [[NSAttributedString alloc] initWithString:text
     attributes:[NSDictionary
     dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],
     NSFontAttributeName,
     paragraphStyle, NSParagraphStyleAttributeName,nil]];
     [paragraphStyle release];
     UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(42.0f, 10.0f, 275.0f, 50.0f)];
     label.attributedText = string;
     [string relase];
     */
    
    //change to notification posting textView, use didChangeSelection
    self.tableDelegate.attributedText = self.textView.attributedText;
    self.tableDelegate.index = 0;
    NSRange range = NSMakeRange(0, 1);
    self.tableDelegate.range = range;
    
    [NSNotificationCenter.defaultCenter addObserverForName:@"CCFontSelected" object:nil queue:NULL usingBlock:^(NSNotification *note) {
        NSMutableAttributedString* attributedText = self.textView.attributedText.mutableCopy;
        NSRange range = NSMakeRange(0, 1);
        CGFloat pointSize = [[self.textView.attributedText attribute:NSFontAttributeName atIndex:self.textView.selectedRange.location effectiveRange:&range] pointSize];
        UIFont* font = [UIFont fontWithName:[note.object fontName] size:pointSize];
        [attributedText setAttributes:@{NSFontAttributeName : font}
                        range:self.textView.selectedRange];
        NSRange selectedRange = self.textView.selectedRange;
        self.textView.attributedText = attributedText;
        self.textView.selectedRange = selectedRange;
    }];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSRange range = self.textView.selectedRange;
    if (range.length)
    {
        //change to notification posting textView
        self.tableDelegate.attributedText = self.textView.attributedText;
        self.tableDelegate.index = self.textView.selectedRange.location;
        self.tableDelegate.range = range;
        [self.tableView reloadData];
    }
    
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

@end
