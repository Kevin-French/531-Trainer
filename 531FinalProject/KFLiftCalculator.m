//
//  KFLiftCalculator.m
//  531 Trainer
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import "KFLiftCalculator.h"

@implementation KFLiftCalculator

+(NSInteger)repsForWeek:(NSInteger) week andSet:(NSInteger)set{
    
    if (week == 2) {
        return 3;
    } else if (week == 3) {
        
        if (set == 1) {
            return 5;
        } else if (set == 2) {
            return 3;
        } else {
            return 1;
        }
    } else if (week == 1 || week == 4){
        return 5;
    } else {
        return 0;
    }
}

+(NSInteger)weightForWeek:(NSInteger) week andSet:(NSInteger)set fromMax:(NSInteger)max {
    
    if ([KFLiftCalculator invalidWeek:week orSet:set]) {
        return 0;
    }
    
    NSInteger workingMax = 0.9 * max;
    
    if (week == 1) {
        
        if (set == 1) {
            return 0.65 * workingMax;
        } else if (set == 2) {
            return 0.75 * workingMax;
        } else {
            return 0.85 * workingMax;
        }
        
    } else if (week == 2) {
        
        if (set == 1) {
            return 0.70 * workingMax;
        } else if (set == 2) {
            return 0.80 * workingMax;
        } else {
            return 0.90 * workingMax;
        }
        
    } else if (week == 3) {
        
        if (set == 1) {
            return 0.75 * workingMax;
        } else if (set == 2) {
            return 0.85 * workingMax;
        } else {
            return 0.95 * workingMax;
        }
        
    } else {
        
        if (set == 1) {
            return 0.45 * workingMax;
        } else if (set == 2) {
            return 0.55 * workingMax;
        } else {
            return 0.65 * workingMax;
        }
        
    }
}

/*
 Returns an integer array of length 9 if using kgs or 5 if using lbs.  Each element in the array
 represents the number of a certain type of plate ot be used per side.
 for kgs [0] = 50kg, [1] = 25kg, [2] = 20kg, [3] = 15kg, [4] = 10kg, [5] = 5kg, [6] = 2.5kg
 [7] = 1.25kg, [8] = 0.5kg
 for lbs [0] = 45lb, [1] = 25lb, [2] = 10lb, [3] = 5lb, [4] = 2.5lb
 */
+(NSArray *)plateCountsInKilosForWeight:(NSInteger)weight {
    
    NSMutableArray * plateCounts = [[NSMutableArray alloc] init];
    
    NSInteger plateWeight = weight - 20;
    
    NSInteger numPlates = [self numberOfPlatesWeighing:50 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 50 * 2;
    
    numPlates = [self numberOfPlatesWeighing:25 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 25 * 2;
    
    numPlates = [self numberOfPlatesWeighing:20 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 20 * 2;
    
    numPlates = [self numberOfPlatesWeighing:15 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 15 * 2;
    
    numPlates = [self numberOfPlatesWeighing:10 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 10 * 2;
    
    numPlates = [self numberOfPlatesWeighing:5 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 5 * 2;
    
    numPlates = [self numberOfPlatesWeighing:2.5 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 2.5 * 2;
    
    return [plateCounts copy];
}

+(NSArray *)plateCountsInPoundsWeight:(NSInteger)weight {
    
    NSMutableArray * plateCounts = [[NSMutableArray alloc] init];
    
    NSInteger plateWeight = weight - 45;
    
    NSInteger numPlates = [self numberOfPlatesWeighing:45 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 45 * 2;
    
    numPlates = [self numberOfPlatesWeighing:25 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 25 * 2;
    
    numPlates = [self numberOfPlatesWeighing:10 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 10 * 2;
    
    numPlates = [self numberOfPlatesWeighing:5 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 5 * 2;
    
    numPlates = [self numberOfPlatesWeighing:2.5 forTotalWeight:plateWeight];
    [plateCounts addObject:[NSNumber numberWithInteger:numPlates]];
    plateWeight -= numPlates * 2.5 * 2;
    
    return [plateCounts copy];
}

+(NSInteger)numberOfPlatesWeighing:(double)plateWeight forTotalWeight:(NSInteger)totalWeight {
    
    return totalWeight / plateWeight * 2;
}

+(BOOL)invalidWeek:(NSInteger)week orSet:(NSInteger)set {
    
    if (week < 1 || week > 4 || set < 1 || set > 3) {
        return YES;
    } else {
        return NO;
    }
}

//-(NSString *) weightString
//{
//    if (oneRepMax > 0) {
//        return [NSString stringWithFormat:@"%i", oneRepMax];
//    } else {
//        return @"One Rep Max (lb)";
//    }
//}

////Returns the string of weight (with correct unit) and how many reps to perform for a set, to be show to the user
//-(NSString *) weightRepString
//{
//
//    NSString * string;
//    int weightForSet = [self calculateWeight];
//    int repsForSet = [self calculateReps];
//
//    if (oneRepMax > 0 && set > 0 && week > 0 && (lb_kg  == 1 || lb_kg == 0)) {
//        if (lb_kg)
//        {
//            if (set == 3 && week != 4)
//                string = [NSString stringWithFormat:@"%ikg for %i+ reps", weightForSet, repsForSet];
//            else
//                string = [NSString stringWithFormat:@"%ikg for %i reps", weightForSet, repsForSet];
//        }
//
//        else
//        {
//            if (self.set == 3 && week != 4)
//                string = [NSString stringWithFormat:@"%ilb for %i+ reps", weightForSet, repsForSet];
//            else
//                string = [NSString stringWithFormat:@"%ilb for %i reps", weightForSet, repsForSet];
//        }
//    } else {
//        string = @"";
//    }
//
//    return string;
//}

@end
