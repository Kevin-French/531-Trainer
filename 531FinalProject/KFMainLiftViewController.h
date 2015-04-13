//
//  KFViewController.h
//  531withAssistance
//
//  Created by Kevin French on 1/21/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFMainLiftSettings.h"
#import "KFTools.h"
#import "KFRecordVideoViewController.h"




@interface KFMainLiftViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UITextField *maxInput;

@property (strong, nonatomic) IBOutlet UILabel *weightRepString;
@property (strong, nonatomic) IBOutlet UILabel *lb45, *lb25, *lb10, *lb5, *lb2point5;
@property (strong, nonatomic) IBOutlet UILabel *kg25, *kg20, *kg15, *kg10, *kg5, *kg2point5, *kg1point25, *kg0point5;
@property (strong, nonatomic) IBOutlet UIButton *assistanceCalculator;
@property (strong, nonatomic) IBOutlet UIButton *recordLift;

@property (strong, nonatomic) IBOutlet UIButton *Clear531;
@property (strong, nonatomic) IBOutlet UIButton *Pounds, *Kilos;
@property (strong, nonatomic) IBOutlet UIButton *Set1, *Set2, *Set3;
@property (strong, nonatomic) IBOutlet UIButton *Week1, *Week2, *Week3, *Week4;

@property (strong, nonatomic) KFMainLiftSettings * settings;
@property (strong, nonatomic) NSString * dataFilePath;
@property (strong, nonatomic) NSMutableArray * savedInfo;

- (IBAction) clickWeek:(UIButton *) sender;
- (IBAction) clickSet:(UIButton *) sender;
- (IBAction) clickPoundsKilos:(UIButton *) sender;
- (IBAction) click531:(id)sender;


- (IBAction)infoPushed:(id)sender;

-(void) displayWeightandReps;
-(void) hidePoundPlates;
-(void) hideKiloPlates;
//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;



*/
@end
