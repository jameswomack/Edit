//
//  NSObject+CCSwizzlers.h
//  Edit
//
//  Created by James Womack on 2/25/13.
//  Copyright (c) 2013 James Womack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CCSwizzlers)

- (void)swapSelector:(SEL)originalSelector withSelector:(SEL)supplementarySelector;

+ (void)swapInstanceSelector:(SEL)originalSelector withSelector:(SEL)supplementarySelector;
+ (void)swapSelector:(SEL)originalSelector withSelector:(SEL)supplementarySelector;

@end
