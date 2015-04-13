//
//  KFMainLiftSettings.m
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFMainLiftSettings.h"

@implementation KFMainLiftSettings
@synthesize week, set, lb_kg, oneRepMax;

//Determines the number of reps to be performed for each set depending on the selected week
-(int) calculateReps
{
    int reps;
    
    if (week == 2) {
        reps = 3;
    }
    else if (week == 3) {
        if (set == 1) {
            reps = 5;
        }
        else if (set == 2) {
            reps = 3;
        }
        else {
            reps = 1;
        }
    }
    else {
        reps = 5;
    }
    
    return reps;
}

//Determines the weight for each set depending on the week and the set
-(int) calculateWeight
{
    int weight;
    
    int _90percentOf1RM = 0.9 * oneRepMax;
    
    int _45percent = 0.45 * _90percentOf1RM;
    int _55percent = 0.55 * _90percentOf1RM;
    int _65percent = 0.65 * _90percentOf1RM;
    int _70percent = 0.70 * _90percentOf1RM;
    int _75percent = 0.75 * _90percentOf1RM;
    int _80percent = 0.80 * _90percentOf1RM;
    int _85percent = 0.85 * _90percentOf1RM;
    int _90percent = 0.90 * _90percentOf1RM;
    int _95percent = 0.95 * _90percentOf1RM;
    
    
    if (week == 1)
    {
        if (set == 1) {
            weight = _65percent;
        }
        
        else if (set == 2) {
            weight = _75percent;
        }
        
        else {
            weight = _85percent;
        }
    }
    
    else if (week == 2)
    {
        if (set == 1) {
            weight = _70percent;
        }
        
        else if (set == 2) {
            weight = _80percent;
        }
        
        else {
            weight = _90percent;
        }
    }
    
    else if (week == 3)
    {
        if (set == 1) {
            weight = _75percent;
        }
        else if (set == 2) {
            weight = _85percent;
        }
        else {
            weight = _95percent;
        }
    }
    
    else
    {
        if (set == 1) {
            weight = _45percent;
        }
        
        else if (set == 2) {
            weight = _55percent;
        }
        
        else {//(set == 3)
            weight = _65percent;
        }
    }
    
    //Kilos
    if (lb_kg) {
        weight = [KFTools convertToKilos:weight];
    }
    
    return weight;
}

-(NSString *) weightString
{
    if (oneRepMax > 0) {
        return [NSString stringWithFormat:@"%i", oneRepMax];
    } else {
        return @"One Rep Max (lb)";
    }
}

//Returns the string of weight (with correct unit) and how many reps to perform for a set, to be show to the user
-(NSString *) weightRepString
{

    NSString * string;
    int weightForSet = [self calculateWeight];
    int repsForSet = [self calculateReps];
    
    if (oneRepMax > 0 && set > 0 && week > 0 && (lb_kg  == 1 || lb_kg == 0)) {
        if (lb_kg)
        {
            if (set == 3 && week != 4)
                string = [NSString stringWithFormat:@"%ikg for %i+ reps", weightForSet, repsForSet];
            else
                string = [NSString stringWithFormat:@"%ikg for %i reps", weightForSet, repsForSet];
        }
        
        else
        {
            if (self.set == 3 && week != 4)
                string = [NSString stringWithFormat:@"%ilb for %i+ reps", weightForSet, repsForSet];
            else
                string = [NSString stringWithFormat:@"%ilb for %i reps", weightForSet, repsForSet];
        }
    } else {
        string = @"";
    }
    
    return string;
}

/*
 Returns an integer array of length 9 if using kgs or 5 if using lbs.  Each element in the array
 represents the number of a certain type of plate ot be used per side.
 for kgs [0] = 50kg, [1] = 25kg, [2] = 20kg, [3] = 15kg, [4] = 10kg, [5] = 5kg, [6] = 2.5kg
 [7] = 1.25kg, [8] = 0.5kg
 for lbs [0] = 45lb, [1] = 25lb, [2] = 10lb, [3] = 5lb, [4] = 2.5lb
 */
-(int *) plateCounts;
{
    int * plates;
    int plateWeight;
    int num_plates;
    
    if (lb_kg == 1)
    {
        plates = malloc(sizeof(int) * 9);
        
        plateWeight = [self calculateWeight] - 20;
        
        if (plateWeight < 1) {
            free(plates);
            return NULL;
        }
        
        num_plates = plateWeight/100;
        
        plates[0] = num_plates;
        if (num_plates)
            plateWeight -= (100*num_plates);
        
        num_plates = plateWeight/50;
        plates[1] = num_plates;
        if (num_plates)
            plateWeight -= (50*num_plates);
        
        num_plates = plateWeight/40;
        plates[2] = num_plates;
        if (num_plates)
            plateWeight -= 40;
        
        num_plates = plateWeight/30;
        plates[3] = num_plates;
        if (num_plates)
            plateWeight -= 30;
        
        num_plates = plateWeight/20;
        plates[4] = num_plates;
        if (num_plates)
            plateWeight -= 20;
        
        num_plates = plateWeight/10;
        plates[5] = num_plates;
        if (num_plates)
            plateWeight -= 10;
        
        num_plates = plateWeight/5;
        plates[6] = num_plates;
        if (num_plates)
            plateWeight -= 5;
        
        num_plates = plateWeight/2.5;
        plates[7] = num_plates;
        if (num_plates)
            plateWeight -= 2.5;
        
        num_plates = plateWeight/1;
        plates[8] = num_plates;
//        if (num_plates)
//            plateWeight -= 1;
    }
    
    else
    {
        
        plateWeight = [self calculateWeight] - 45;
        
        //Round to nearest 5
        plateWeight = 5.0 * floor((plateWeight/5.0)+0.5);
        
        if (plateWeight < 5) {
            return NULL;
        }
        
        plates = malloc(sizeof(int) * 5);

        num_plates = plateWeight/90;
        plates[0] = num_plates;
        if (num_plates)
            plateWeight -= (90*num_plates);
        
        num_plates = plateWeight/50;
        plates[1] = num_plates;
        if (num_plates)
            plateWeight -= (50*num_plates);
        
        num_plates = plateWeight/20;
        plates[2] = num_plates;
        if (num_plates)
            plateWeight -= (20*num_plates);
        
        num_plates = plateWeight/10;
        plates[3] = num_plates;
        if (num_plates)
            plateWeight -= (10*num_plates);
        
        num_plates = plateWeight/5;
        plates[4] = num_plates;
//        if (num_plates)
//            plateWeight -= (5*num_plates);
    }
    
    return plates;
}

@end

