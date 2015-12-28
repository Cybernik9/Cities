//
//  LogicGameViewController.m
//  Cities game
//
//  Created by Admin on 26.12.15.
//  Copyright © 2015 HY. All rights reserved.
//

#import "LogicGame.h"

@implementation LogicGame

static NSUInteger const countImages = 10;

+ (NSMutableArray *)logicGameWithArray:(NSArray *)activeCitiesArray {
    
    NSMutableArray *buttonArrayName = [[NSMutableArray alloc]
                                       initWithObjects:[activeCitiesArray firstObject], nil];
    
    NSMutableArray *tempArrayAllName = [[NSMutableArray alloc]
                                        initWithArray:[self getCitiesName] copyItems:YES];
    
    [tempArrayAllName removeObject:[buttonArrayName firstObject]];
    [buttonArrayName addObject:[tempArrayAllName objectAtIndex:arc4random()%(countImages-2)]];
    [tempArrayAllName removeObject:[buttonArrayName objectAtIndex:1]];
    [buttonArrayName addObject:[tempArrayAllName objectAtIndex:arc4random()%(countImages-3)]];
    [tempArrayAllName removeObject:[buttonArrayName objectAtIndex:2]];
    [buttonArrayName addObject:[tempArrayAllName objectAtIndex:arc4random()%(countImages-4)]];
    [tempArrayAllName removeObject:[buttonArrayName objectAtIndex:3]];
    
    return [self shuffle:buttonArrayName];
}

+ (NSMutableArray *)shuffle:(NSArray*) array {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [tempArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    return tempArray;
}

+ (NSArray *)getCitiesName {
    
    NSArray *arrayCities = [[NSArray alloc] initWithObjects:
                            @"Paris", @"London", @"Berlin", @"Lviv", @"Kyiv",
                            @"Krakow", @"Warsaw", @"Oslo", @"Stockholm", @"Toronto", nil];
    
    return arrayCities;
}

@end
