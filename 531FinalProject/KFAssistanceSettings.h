//
//  KFAssistanceSettings.h
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KFTools.h"

@interface KFAssistanceSettings : NSObject

@property int weight, percent, weightForSet, weight_lb_kg, weightForSet_lb_kg, otherUnitWeight, otherUnitWeightForSet;

- (NSString *) weightForSetString;
- (NSString *) weightString;
- (NSString *) percentString;

- (void) weightForSetConverted;
- (void) weightConverted;
- (void) setOtherUnitWeights;

@end
