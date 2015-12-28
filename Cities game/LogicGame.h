//
//  LogicGameViewController.h
//  Cities game
//
//  Created by Admin on 26.12.15.
//  Copyright © 2015 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogicGame : NSObject

+ (NSMutableArray *)logicGameWithArray:(NSArray *)activeCitiesArray;
+ (NSMutableArray*)shuffle:(NSArray*) array;
+ (NSArray *)getCitiesName;

@end
