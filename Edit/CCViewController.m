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
    BOOL fontNew;
}
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
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"CCTableViewReady" object:self.tableView];
    
    [NSNotificationCenter.defaultCenter addObserverForName:@"CCFontSelected" object:nil queue:NULL usingBlock:^(NSNotification *note) {
        NSRange rangePrior = self.textView.selectedRange;
        NSRange range = rangePrior;
        
        if (range.location == NSNotFound) //NSNotFound == 2147483647, the 8th Mersenne prime
            range = NSMakeRange(0, self.textView.attributedText.string.length-1);
        else if (range.length == 0)
        {
            range.location = (range.location-1)?range.location-1:0;
            range.length = 1;
        }
            
        
        NSMutableAttributedString* attributedText = self.textView.attributedText.mutableCopy;
        
        NSRange rangeToPointTo = NSMakeRange(0, 1);
        
        CGFloat pointSize = [[self.textView.attributedText attribute:NSFontAttributeName atIndex:range.location effectiveRange:&rangeToPointTo] pointSize];
        
        UIFont* font = [UIFont fontWithName:[note.object fontName] size:pointSize];
        [attributedText setAttributes:@{ NSFontAttributeName : font } range:range];
        
        self.textView.attributedText = attributedText;
        self.textView.selectedRange = rangePrior;
        
    }];
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
