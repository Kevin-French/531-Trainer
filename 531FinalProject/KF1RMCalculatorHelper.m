//
//  KF1RMCalculatorHelper.m
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KF1RMCalculatorHelper.h"

@implementation KF1RMCalculatorHelper

+(int) calculateEstimateForWeightInLbs:(int)weight reps:(int)reps {
    
    if (reps > 0 && weight > 0) {
         return (weight * reps * 0.03333333) + weight;
    } else {
        return 0;
    }
}

+(int) calculateWeightForRepsInLbs:(int)reps max:(int)max {
    
    if (max > 0 && reps > 0) {
        return (30 * max) / (30 + reps);
    } else {
        return 0;
    }
}
+(int) calculateRepsForWeightInLbs:(int)weight max:(int)max {

    if (max > 0 && weight > 0) {
        return (30 * (max - weight)) / weight;
    } else {
        return 0;
    }
}

@end
