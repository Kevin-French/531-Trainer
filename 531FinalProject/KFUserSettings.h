//
//  KFUserSettings.h
//  531 Trainer
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KFProgramSettings.h"

@interface KFUserSettings : NSObject

@property KFProgramSettings * programSettings;

+(KFUserSettings *)sharedInstance;
-(void)saveSettings;


@end
