//
//  CCTableViewController.m
//  Edit
//
//  Created by James Womack on 2/20/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import "CCTableViewController.h"

@interface CCTableViewController ()
@end

@implementation CCTableViewController


#pragma mark - UIFont

- (NSArray*)fontNamesForSectionIndex:(NSUInteger)section
{
    NSArray* familyNames = UIFont.familyNames;
    NSString* family = familyNames[section];
    NSArray* fontNamesForSectionIndex = [UIFont fontNamesForFamilyName:family];
    return fontNamesForSectionIndex;
}

- (NSString*)currentFontName
{
    NSRange range = self.range;
    UIFont* currentFont = [self.attributedText attribute:NSFontAttributeName atIndex:self.index effectiveRange:&range];
    return currentFont.fontName;
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
    
    NSLog(@"%@ %@",self.attributedText,self.attributedText.class);
    assert(self.attributedText);
    NSAttributedString* aString = [self.attributedText attributedSubstringFromRange:self.range];
    assert(aString);
    NSString* string = aString.string;
    assert(string);
    cell.textLabel.text = string;
    NSRange range = self.range;
    UIFont* font = [self.attributedText attribute:NSFontAttributeName atIndex:self.index effectiveRange:&range];
    cell.textLabel.font = [UIFont fontWithName:[self fontNameForIndexPath:indexPath] size:font.pointSize];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* fontName = [self fontNameForIndexPath:indexPath];
    UIFont* selectedFont = [UIFont fontWithName:fontName size:18.f];
    [NSNotificationCenter.defaultCenter postNotificationName:@"CCFontSelected" object:selectedFont];
}


@end
