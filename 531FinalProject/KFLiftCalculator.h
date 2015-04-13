//
//  KFLiftCalculator.h
//  531 Trainer
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFLiftCalculator : NSObject

+(NSInteger)repsForWeek:(NSInteger) week andSet:(NSInteger)set;
+(NSInteger)weightForWeek:(NSInteger) week andSet:(NSInteger)set fromMax:(NSInteger)max;

+(NSArray *)plateCountsInKilosForWeight:(NSInteger)weight;
+(NSArray *)plateCountsInPoundsWeight:(NSInteger)weight;

//-(NSString *)weightRepString;
//-(NSString *)weightString;

@end
