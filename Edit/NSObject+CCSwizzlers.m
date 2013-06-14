//
//  NSObject+CCSwizzlers.m
//  Edit
//
//  Created by James Womack on 2/25/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//


#import "NSObject+CCSwizzlers.h"
#import "CCSwizzlers.h"



@implementation NSObject (CCSwizzlers)



- (void)swapSelector:(SEL)originalSelector withSelector:(SEL)supplementarySelector
{
    CCSwapInstanceMethods(self.class, originalSelector, supplementarySelector);
}


+ (void)swapInstanceSelector:(SEL)originalSelector withSelector:(SEL)supplementarySelector
{
    CCSwapInstanceMethods(self.class, originalSelector, supplementarySelector);
}


+ (void)swapSelector:(SEL)originalSelector withSelector:(SEL)supplementarySelector
{
    CCSwapClassMethods(self.class, originalSelector, supplementarySelector);
}



@end
