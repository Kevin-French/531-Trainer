//
//  Program.m
//  531withAssistance
//
//  Created by Kevin French on 1/23/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "Program.h"

@implementation Program

@synthesize set, week, oneRepMax, weightForSet, lb_kg, repsForSet;

//Determines the number of reps to be performed for each set depending on the selected week
-(void) determineReps
{
    if (week == 2) {
        repsForSet = 3;
    }
    
    else if (week == 3)
    {
        if (set == 1)
            repsForSet = 5;
        else if (set == 2)
            repsForSet = 3;
        else if (set == 3)
            repsForSet = 1;
    }
    
    else {//(week == 4 || week == 1)
        repsForSet = 5;
    }
}

//Determines the weight for each set depending on the week and the set
-(void) determineWeight
{
    int _90percentOf1RM = 0.9 * oneRepMax;
    
    int _45percent = 0.45 * _90percentOf1RM;
    int _55percent = 0.55 * _90percentOf1RM;
    int _65percent = 0.65 * _90percentOf1RM;
    int _70percent = 0.70 * _90percentOf1RM;
    int _75percent = 0.75 * _90percentOf1RM;
    int _80percent = 0.70 * _90percentOf1RM;
    int _85percent = 0.85 * _90percentOf1RM;
    int _90percent = 0.90 * _90percentOf1RM;
    int _95percent = 0.95 * _90percentOf1RM;

    
    if (week == 1)
    {
        if (set == 1) {
            weightForSet = _65percent;
        }
        
        else if (set == 2) {
            weightForSet = _75percent;
        }
        
        else {//(set == 3)
            weightForSet = _85percent;
        }
    }
    
    else if (week == 2)
    {
        if (set == 1) {
            weightForSet = _70percent;
        }
        
        else if (set == 2) {
            weightForSet = _80percent;
        }
        
        else {//(set == 3)
            weightForSet = _90percent;
        }
    }
    
    else if (week == 3)
    {
        if (set == 1) {
            weightForSet = _75percent;
        }
        else if (set == 2) {
            weightForSet = _85percent;
        }
        else {//(set == 3)
            weightForSet = _95percent;
        }
    }
    
    else //(week == 4)
    {
        if (set == 1) {
            weightForSet = _45percent;
        }
        
        else if (set == 2) {
            weightForSet = _55percent;
        }
        
        else {//(set == 3)
            weightForSet = _65percent;
        }
    }
    
    if (lb_kg == 2) {
        weightForSet /= 2.20462;
    }
}

//Helper function to calculate both reps and weight
-(void) determineBoth
{
    [self determineReps];
    [self determineWeight];
}

//Returns the string of weight (with correct unit) and how many reps to perform for a set, to be show to the user
-(NSString *) weightRepString
{
    NSString * string;
    
    if (lb_kg == 2)
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
    
    return string;
}

/*
 Returns an integer array of length 9 if using kgs or 5 if using lbs.  Each element in the array
 represents the number of a certain type of plate ot be used per side.
 for kgs [0] = 50kg, [1] = 25kg, [2] = 20kg, [3] = 15kg, [4] = 10kg, [5] = 5kg, [6] = 2.5kg
 [7] = 1.25kg, [8] = 0.5kg
 for lbs [0] = 45lb, [1] = 25lb, [2] = 10lb, [3] = 5lb, [4] = 2.5lb
 */
-(int *)plateCount;
{
    int * plates;
    int weight;
    int num_plates;
    
    if (lb_kg == 2)
    {
        plates = malloc(sizeof(int) * 9);
        
        weight = weightForSet - 20;
        
        num_plates = weight/100;
        
        plates[0] = num_plates;
        if (num_plates)
            weight -= (100*num_plates);
        
        num_plates = weight/50;
        plates[1] = num_plates;
        if (num_plates)
            weight -= (50*num_plates);
        
        num_plates = weight/40;
        plates[2] = num_plates;
        if (num_plates)
            weight -= 40;
        
        num_plates = weight/30;
        plates[3] = num_plates;
        if (num_plates)
            weight -= 30;
        
        num_plates = weight/20;
        plates[4] = num_plates;
        if (num_plates)
            weight -= 20;
        
        num_plates = weight/10;
        plates[5] = num_plates;
        if (num_plates)
            weight -= 10;
        
        num_plates = weight/5;
        plates[6] = num_plates;
        if (num_plates)
            weight -= 5;
        
        num_plates = weight/2.5;
        plates[7] = num_plates;
        if (num_plates)
            weight -= 2.5;
        
        num_plates = weight/1;
        plates[8] = num_plates;
        if (num_plates)
            weight -= 1;
    }
    
    else
    {
        plates = malloc(sizeof(int) * 5);
        
        weight = weightForSet - 45;
        num_plates = weight/90;
        plates[0] = num_plates;
        if (num_plates)
            weight -= (90*num_plates);
        
        num_plates = weight/50;
        plates[1] = num_plates;
        if (num_plates)
            weight -= (50*num_plates);
        
        num_plates = weight/20;
        plates[2] = num_plates;
        if (num_plates)
            weight -= (20*num_plates);
        
        num_plates = weight/10;
        plates[3] = num_plates;
        if (num_plates)
            weight -= (10*num_plates);
        
        num_plates = weight/5;
        plates[4] = num_plates;
        if (num_plates)
            weight -= (5*num_plates);
    }
    
    return plates;
}

@end
