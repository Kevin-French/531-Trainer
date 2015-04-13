//
//  KFProgramSettings.h
//  531 Trainer
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFProgramSettings : NSObject

@property NSInteger militaryPressMax, deadLiftMax, benchPressMax, squatMax, cycle;
@property NSInteger militaryPressIncrementPerCycle, deadliftIncrementPerCycle, benchPressIncrementPerCycle, squatIncrementPerCycle;

-(instancetype)initWithArray:(NSArray *)array;
-(void) incrementCycle;
-(void) logSettings;

@end