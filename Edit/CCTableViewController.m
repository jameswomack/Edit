//
//  CCTableViewController.m
//  Edit
//
//  Created by James Womack on 2/20/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import "CCTableViewController.h"
#import "UITableViewCell+CCAttributedStringDescriptor.h"

@interface CCTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong) UITableView* tableView;
@property (strong) NSAttributedString* attributedText;
@property NSRange range;
@end

@implementation CCTableViewController

- (id)init
{
    if ((self = [super init]))
    {        
        [NSNotificationCenter.defaultCenter addObserverForName:@"CCTableViewReady" object:nil queue:NULL usingBlock:^(NSNotification *note) {
            self.tableView = note.object;
        }];
        
        [NSNotificationCenter.defaultCenter addObserverForName:@"CCTextViewSelectionChanged" object:nil queue:NULL usingBlock:^(NSNotification *note) {
            UITextView* textView = note.object;
            NSRange range = textView.selectedRange;
            if (!range.length)
            {
                [self dummify];
                return;
            }
                
            
            self.attributedText = textView.attributedText;
            self.range = range;
            [self.tableView reloadData];
        }];
        
        [self dummify];
    }
    return self;
}

- (void)dummify
{
    UITextView* dummyTextView = UITextView.new;
    dummyTextView.attributedText = [NSAttributedString.alloc initWithString:@"Lorem Ipsum"];
    dummyTextView.selectedRange = NSMakeRange(0, dummyTextView.attributedText.string.length);
    [NSNotificationCenter.defaultCenter postNotificationName:@"CCTextViewSelectionChanged" object:dummyTextView];
}

#pragma mark - UIFont

- (NSString*)fontFamilyForSectionIndex:(NSUInteger)section
{
    if (section)
    {
        NSArray* familyNames = UIFont.familyNames;
        
        NSString* family = familyNames[section];
        
        return family;
    }
    else
    {
        return self.currentFont.familyName;
    }
}

- (NSArray*)fontNamesForSectionIndex:(NSUInteger)section
{
    NSString* family = [self fontFamilyForSectionIndex:section];
    NSArray* fontNamesForSectionIndex = [UIFont fontNamesForFamilyName:family];
    return fontNamesForSectionIndex;
}

- (UIFont*)currentFont
{
    NSRange range = self.range;
    UIFont* currentFont = [self.attributedText attribute:NSFontAttributeName atIndex:self.range.location effectiveRange:&range];
    return currentFont;
}

- (NSString*)currentFontName
{
    return self.currentFont.fontName;
}

- (NSString*)fontNameForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section)
    {
        NSArray* fontNamesForSectionIndex = [self fontNamesForSectionIndex:indexPath.section];
        
        NSString* fontNameForIndexPath =  fontNamesForSectionIndex[indexPath.row];
        
        return fontNameForIndexPath;
    }
    else
    {
        return self.currentFontName;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return UIFont.familyNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section)
    {
        return [self fontNamesForSectionIndex:section].count;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    [cell displayForAttributedString:self.attributedText withFontName:[self fontNameForIndexPath:indexPath] andRange:self.range andIndexPath:indexPath];
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self fontFamilyForSectionIndex:section];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* fontName = [self fontNameForIndexPath:indexPath];
    UIFont* selectedFont = [UIFont fontWithName:fontName size:18.f];
    [NSNotificationCenter.defaultCenter postNotificationName:@"CCFontSelected" object:selectedFont];
}


@end
