//
//  KF1RMCalculatorHelper.h
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KFTools.h"


@interface KF1RMCalculatorHelper : NSObject

+(int) calculateEstimateForWeightInLbs:(int)weight reps:(int)reps;
+(int) calculateWeightForRepsInLbs:(int)reps max:(int)max;
+(int) calculateRepsForWeightInLbs:(int)weight max:(int)max;

@end
