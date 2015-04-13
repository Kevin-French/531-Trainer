//
//  KFSettings.h
//  531withAssistance
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFMainMenuViewController.h"
#import "KFSettingsViewController.h"
#import "KFTools.h"

@interface KFSettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *militaryPressInput, *deadLiftInput, *benchPressInput, *squatInput, *cycleInput;
@property (strong, nonatomic) IBOutlet UIButton *nextCycle, *militaryPressIncrement, *deadLiftIncrement, *benchPressIncrement, *squatIncrement;
@property (strong, nonatomic) NSMutableArray * savedInfo;

//@property KFSettings * settings;
@property NSString * dataFilePath;

- (IBAction)infoPressed:(id)sender;

- (IBAction)pushed531:(id)sender;

- (IBAction)militaryPressIncrementPressed:(id)sender;
- (IBAction)deadLiftIcrementPressed:(id)sender;
- (IBAction)benchPressIncrementPressed:(id)sender;
- (IBAction)squatIncrementPressed:(id)sender;
- (IBAction)cycleIncrementPressed:(id)sender;



-(void) saveData;

@end
