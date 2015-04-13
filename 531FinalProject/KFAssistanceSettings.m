//
//  KFAssistanceSettings.m
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFAssistanceSettings.h"

@implementation KFAssistanceSettings

@synthesize weight, percent, weightForSet, weight_lb_kg, weightForSet_lb_kg, otherUnitWeight, otherUnitWeightForSet;

- (void) weightForSetConverted
{
    int temp = weightForSet;
    weightForSet = otherUnitWeightForSet;
    otherUnitWeightForSet = temp;
    
}

- (void) weightConverted
{
    int temp = weight;
    weight = otherUnitWeight;
    otherUnitWeight = temp;
}

- (void) setOtherUnitWeights {
    
    if (weight_lb_kg) {
        otherUnitWeight = [KFTools convertToPounds:weight];
    } else {
        otherUnitWeight = [KFTools convertToKilos:weight];
    }

    if (weightForSet_lb_kg) {
        otherUnitWeightForSet = [KFTools convertToPounds:weightForSet];
    } else {
        otherUnitWeightForSet = [KFTools convertToKilos:weightForSet];
    }
}

/*
 Returns an integer corresponding to the weight for set if a valid combination of weight and
 percent have been inputed, 0 otherwise
 */
- (int) calculateWeightForSet
{
    NSLog(@"CalculateWeightForSet Called in Assistance");
    
    NSLog(@"weight = %i, otherWeight = %i, weightForSet = %i, otherUnitWeightForSet = %i", weight, otherUnitWeight, weightForSet, otherUnitWeightForSet);
    
    if (percent > 0 && weight > 0) {
        weightForSet = weight*percent;
        weightForSet /= 100;
        
        //In Different Units
        if (weight_lb_kg != weightForSet_lb_kg) {
            if (weight_lb_kg) {
                otherUnitWeightForSet = weightForSet;
                weightForSet = [KFTools convertToPounds:weightForSet];
            } else {
                otherUnitWeightForSet = weightForSet;
                weightForSet = [KFTools convertToKilos:weightForSet];
            }
            
        } else {
            if (weightForSet_lb_kg) {
                otherUnitWeightForSet = [KFTools convertToPounds:weightForSet];
            } else {
                otherUnitWeightForSet = [KFTools convertToKilos:weightForSet];
            }
        }
        
    } else {
        weightForSet = 0;
    }
    
    NSLog(@"weight = %i, otherWeight = %i, weightForSet = %i, otherUnitWeightForSet = %i", weight, otherUnitWeight, weightForSet, otherUnitWeightForSet);

    
    return weightForSet;

}

/*
 Returns a string to be displayed in the weight for set input
 */
- (NSString *) weightForSetString
{
    NSString * string;
    
    NSLog(@"weight = %i, percent = %i, weightForSet = %i", weight, percent, weightForSet);
    
    if (percent > 0 && weight > 0) {
        weightForSet = [self calculateWeightForSet];
        if (weight > 0) {
            string = [NSString stringWithFormat:@"%i", weightForSet];
        } else {
            string = @"Weight For Set";
        }
        
    } else {
        if (weightForSet > 0) {
            string = [NSString stringWithFormat:@"%i", weightForSet];
        } else {
            string = @"Weight For Set";
        }
    }
    
    return string;
}


/*
 Returns a string to be displayed in the percent input
 */
- (NSString *) percentString
{
    NSString * string;
    
    if (percent > 0) {
        string = [NSString stringWithFormat:@"%i", percent];
    } else {
        string = @"Percent";
    }
    
    return string;
}

/*
 Returns a string to be displayed in the weight input
 */
- (NSString *) weightString
{
    NSString * string;
    
    if (weight > 0) {
        string = [NSString stringWithFormat:@"%i", weight];
    } else {
        string = @"Weight";
    }
    
    return string;
}




@end
