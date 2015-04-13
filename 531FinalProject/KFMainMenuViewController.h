//
//  KFMainMenuViewController.h
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFMainMenuSettings.h"
#import "KFTools.h"

@interface KFMainMenuViewController : UIViewController

- (void) saveData;
- (IBAction)settingsPressed:(id)sender;
- (IBAction)oneRepMaxCalculatorPressed:(id)sender;
- (IBAction)chooseLift:(id)sender;
- (IBAction)menuInfoPushed:(id)sender;


@end