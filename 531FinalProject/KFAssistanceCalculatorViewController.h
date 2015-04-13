//
//  KFAssistanceCalculatorViewController.h
//  531withAssistance
//
//  Created by Kevin French on 2/1/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFAssistanceSettings.h"
#import "KFTools.h"

@interface KFAssistanceCalculatorViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *weight, *percent, *weightForSet;
@property (strong, nonatomic) NSString * dataFilePath;
@property (strong, nonatomic) KFAssistanceSettings * settings;
@property (strong, nonatomic) NSMutableArray * savedInfo;
@property (strong, nonatomic) IBOutlet UIButton *weightForSetPoundsUnitButton, *weightForSetKilosUnitButton, *weightPoundsUnitButton, *weightKilosUnitButton;
@property UILabel * label;

- (IBAction)clickPoundsKilosForWeight:(UIButton *)sender;
- (IBAction)clickPoundsKilosForWeightForSet:(UIButton *)sender;
- (IBAction)infoPressed:(id)sender;

- (IBAction)clear531:(id)sender;

- (void) highlightPoundKiloWeightButtonFor: (int) lb_kg;
- (void) highlightPoundKiloWeightForSetButtonFor: (int) lb_kg;

- (void) setPoundKiloWeightButtonsToGray;
- (void) setPoundKiloWeightForSetButtonsToGray;

@end

