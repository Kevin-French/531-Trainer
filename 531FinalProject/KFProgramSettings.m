//
//  KFProgramSettings.m
//  531 Trainer
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import "KFProgramSettings.h"

@implementation KFProgramSettings

- (void) logSettings {
    NSLog(@"\n\n\nlogContents NOT YET IMPLEMENTED\n\n\n");
}

-(instancetype)initWithArray:(NSArray *)array {
    
    if (self = [super init]) {
        self.militaryPressMax = [[array objectAtIndex:0] integerValue];
        self.deadLiftMax = [[array objectAtIndex:1] integerValue];
        self.benchPressMax = [[array objectAtIndex:2] integerValue];
        self.squatMax = [[array objectAtIndex:3] integerValue];
        self.cycle = [[array objectAtIndex:4] integerValue];
        self.militaryPressIncrementPerCycle = [[array objectAtIndex:5] integerValue];
        self.deadliftIncrementPerCycle = [[array objectAtIndex:6] integerValue];
        self.benchPressIncrementPerCycle = [[array objectAtIndex:7] integerValue];
        self.squatIncrementPerCycle = [[array objectAtIndex:8] integerValue];
    }
    
    return self;
}

/*
 Increments the cycle by 1 and the lifts according to their individual incrementing amounts
 */
- (void) incrementCycle
{
    if (self.cycle > 0) {
        
        self.militaryPressMax = MAX(self.militaryPressMax + self.militaryPressIncrementPerCycle, 0);
        self.deadLiftMax = MAX(self.deadLiftMax + self.deadliftIncrementPerCycle, 0);
        self.benchPressMax = MAX(self.benchPressMax + self.benchPressIncrementPerCycle, 0);
        self.benchPressMax = MAX(self.squatMax + self.squatIncrementPerCycle, 0);
        
        if (self.militaryPressMax > 0 || self.deadLiftMax > 0 || self.benchPressMax > 0 || self.squatMax > 0) {
            self.cycle++;
        }
        
    } else {
        self.cycle = 1;
    }
}

@end
