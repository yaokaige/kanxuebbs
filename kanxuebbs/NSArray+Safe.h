//
//  NSArray+Safe.h
//
//  Created by sgl on 1/2/13.
//  Copyright (c) 2013 sgl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)
- (id)safeObjectAtIndex:(NSUInteger)index;
@end
