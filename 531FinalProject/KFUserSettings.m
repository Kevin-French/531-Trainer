//
//  KFUserSettings.m
//  531 Trainer
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import "KFUserSettings.h"

@interface KFUserSettings ()

@property NSMutableArray * settings;
@property NSUserDefaults * userDefaults;

@end

@implementation KFUserSettings

+(KFUserSettings *) sharedInstance
{
    static KFUserSettings * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[KFUserSettings alloc] init];
    });
    
    return _sharedInstance;
}

-(id)init {
    
    if (self = [super init]) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.settings = [self.userDefaults objectForKey:@"settings"];
    }
    
    return self;
}

-(void)saveSettings {
    
    [self.userDefaults setObject:self.settings forKey:@"settings"];
    [self.userDefaults synchronize];
}

-(KFProgramSettings *)programSettings {
    
    NSArray * array = [self.settings subarrayWithRange:NSMakeRange(0, 9)];
    return [[KFProgramSettings alloc] initWithArray:array];
}

-(void)setProgramSettings:(KFProgramSettings *)programSettings {
    self.programSettings = programSettings;
}

@end
