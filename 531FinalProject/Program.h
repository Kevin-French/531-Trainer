//
//  Program.h
//  531withAssistance
//
//  Created by Kevin French on 1/23/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Program : NSObject

@property int set, week, oneRepMax, weightForSet, repsForSet, lb_kg;

-(void) determineReps;
-(void) determineWeight;
-(void) determineBoth;
-(NSString *) weightRepString;
-(int *)plateCount;


@end
