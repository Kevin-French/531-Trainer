//
//  KFViewController.m
//  531withAssistance
//
//  Created by Kevin French on 1/21/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFMainLiftViewController.h"

@interface KFMainLiftViewController ()

@end

@implementation KFMainLiftViewController /*
{
    NSDate * set1Date;
    NSDate * set2Date;
    NSDate * set3Date;
    NSDate * lastSet;
    NSDateFormatter * dateFormatter;
}
@synthesize lb45, lb25, lb10, lb5, lb2point5, maxInput, weightRepString, Pounds, Kilos, Set1, Set2, Set3, Week1, Week2, Week3, Week4, kg25, kg20, kg15, kg10, kg5, kg2point5, kg1point25, kg0point5, settings, dataFilePath, savedInfo, assistanceCalculator, recordLift;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [self hideAllPlates];
    
    //Pass weight rep string to record lift before switching to have in the share string
    if([segue.identifier isEqualToString:@"MainLift-RecordLift"]){
            KFRecordVideoViewController *controller = (KFRecordVideoViewController *)segue.destinationViewController;
            controller.weightRepString = [settings weightRepString];
        }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    
    //Hide toolbar that may still be up from the record lift view
    [self.navigationController setToolbarHidden:YES];

    //Hide all plates before display the correct ones
    [self hideAllPlates];
    [self displayPlates];

}

- (void)setAllLabelsInfo
{
    [self setLabelInfo:lb2point5 name:@"2.5"];
    [self setLabelInfo:lb5 name:@"5"];
    [self setLabelInfo:lb10 name:@"10"];
    [self setLabelInfo:lb25 name:@"25"];
    [self setLabelInfo:lb45 name:@"45"];
    [self setLabelInfo:kg0point5 name:@"0.5"];
    [self setLabelInfo:kg1point25 name:@"1.25"];
    [self setLabelInfo:kg2point5 name:@"2.5"];
    [self setLabelInfo:kg5 name:@"5"];
    [self setLabelInfo:kg10 name:@"10"];
    [self setLabelInfo:kg15 name:@"15"];
    [self setLabelInfo:kg20 name:@"20"];
    [self setLabelInfo:kg25 name:@"25"];
}

- (void)addAllLabelSubviews
{
    [self.view addSubview:lb2point5];
    [self.view addSubview:lb5];
    [self.view addSubview:lb10];
    [self.view addSubview:lb25];
    [self.view addSubview:lb45];
    [self.view addSubview:kg0point5];
    [self.view addSubview:kg1point25];
    [self.view addSubview:kg2point5];
    [self.view addSubview:kg5];
    [self.view addSubview:kg10];
    [self.view addSubview:kg15];
    [self.view addSubview:kg20];
    [self.view addSubview:kg25];
}

- (void)setAllPlateColors
{
    [lb2point5 setBackgroundColor:[UIColor darkGrayColor]];
    [lb5 setBackgroundColor:[UIColor darkGrayColor]];
    [lb10 setBackgroundColor:[UIColor darkGrayColor]];
    [lb25 setBackgroundColor:[UIColor darkGrayColor]];
    [lb45 setBackgroundColor:[UIColor darkGrayColor]];
    
    [kg0point5 setBackgroundColor:[UIColor lightGrayColor]];
    [kg1point25 setBackgroundColor:[UIColor lightGrayColor]];
    [kg2point5 setBackgroundColor:[UIColor lightGrayColor]];
    [kg5 setBackgroundColor:[UIColor lightGrayColor]];
    [kg10 setBackgroundColor:[UIColor lightGrayColor]];
    [kg15 setBackgroundColor:[UIColor yellowColor]];
    [kg20 setBackgroundColor:[UIColor blueColor]];
    [kg25 setBackgroundColor:[UIColor redColor]];
}

- (void)createPlates
{
    lb2point5 = [[UILabel alloc] initWithFrame:CGRectMake(136.0, 343.0, 48.0, 12.0)];
    lb5 = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 343.0, 80.0, 16.0)];
    lb10 = [[UILabel alloc] initWithFrame:CGRectMake(87.0, 343.0, 150.0, 18.0)];
    lb25 = [[UILabel alloc] initWithFrame:CGRectMake(53.0, 343.0, 215.0, 21.0)];
    lb45 = [[UILabel alloc] initWithFrame:CGRectMake(11.0, 343.0, 298.0, 25.0)];
    
    kg0point5 = [[UILabel alloc] initWithFrame:CGRectMake(116.0, 343.0, 89.0, 8.0)];
    kg1point25 = [[UILabel alloc] initWithFrame:CGRectMake(107.0, 343.0, 106.0, 8.0)];
    kg2point5 = [[UILabel alloc] initWithFrame:CGRectMake(97.0, 343.0, 126.0, 10.0)];
    kg5 = [[UILabel alloc] initWithFrame:CGRectMake(88.0, 343.0, 149.0, 13.0)];
    kg10 = [[UILabel alloc] initWithFrame:CGRectMake(55.0, 343.0, 210.0, 13.0)];
    kg15 = [[UILabel alloc] initWithFrame:CGRectMake(31.0, 343.0, 258.0, 13.0)];
    kg20 = [[UILabel alloc] initWithFrame:CGRectMake(11.0, 343.0, 298.0, 12.0)];
    kg25 = [[UILabel alloc] initWithFrame:CGRectMake(11.0, 343.0, 298.0, 16.0)];
}

- (void)platesToStartingPositions
{
    [self createPlates];
    [self setAllPlateColors];
    [self setAllLabelsInfo];
    [self addAllLabelSubviews];
    [self hideAllPlates];
}

- (void) setLabelInfo: (UILabel *) label name: (NSString *) name {
    [label setNumberOfLines:1];
    [label setTextAlignment: NSTextAlignmentCenter];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setMinimumScaleFactor: 1.0];
    [label setFont:[UIFont systemFontOfSize:11]];
    [label setTextColor:[UIColor blackColor]];
    [label setText:name];
}

- (void)setTargetActionForSetButtons
{
	//Set target-actions for single and double touch
    [Set1 addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
	[Set1 addTarget:self action:@selector(touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
    [Set2 addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
	[Set2 addTarget:self action:@selector(touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
    [Set3 addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
	[Set3 addTarget:self action:@selector(touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
}

- (void)setUpDatesForSetTimeInformation
{
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh : mm : ss a"];
    
    set1Date = [NSDate date];
    lastSet = set1Date;
    
    set2Date = nil;
    set3Date = nil;
}

- (void)getScreenSizeInformation
{
    //Get screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    //Set boolean value for whether or not using an iPhone5
    if (screenHeight == 568) {
        iPhone5 = YES;
    } else {
        iPhone5 = NO;
    }
}

/*
 Allocates a myProgram variable and sets all the plates to hidden when the view loads
 */

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self setTargetActionForSetButtons];

    [self setUpDatesForSetTimeInformation];

    [self getScreenSizeInformation];
    
    [self.navigationController setToolbarHidden:YES];

    
    [self platesToStartingPositions];
    
    
    settings = [[KFMainLiftSettings alloc] init];
    
    //Load setting
    NSFileManager * fm;
    NSString * docsDir;
    NSArray * dirPaths;
    
    fm = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"/data.archive"]];
    
    if ([fm fileExistsAtPath:dataFilePath]) {
        savedInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        
        //If a previous lift selection has been made, tells which max to load
        if ([savedInfo count] >= 10) {
            
            int selectedLift = [savedInfo[9] intValue];
            int selectedLiftWeight = [savedInfo[selectedLift - 1] intValue];
            [settings setOneRepMax:selectedLiftWeight];
            
            if (selectedLiftWeight > 0) {
                [maxInput setText: [NSString stringWithFormat:@"%i", selectedLiftWeight]];
            } else {
                [maxInput setText: @"One Rep Max (lb)"];
            }
            
            
        }
        //Default
        else {
            [maxInput setText: @"One Rep Max (lb)"];
            [settings setOneRepMax:0];
        }
        
        //If a week, set, and lb_kg selection have been made in the past
        if ([savedInfo count] >= 18) {
            [settings setWeek: [savedInfo[15] intValue]];
            [settings setSet: [savedInfo[16] intValue]];
            [settings setLb_kg: [savedInfo[17] intValue]];
            
            [self highlightWeekButtonForWeek: [settings week]];
            [self highlightSetButtonForSet: [settings set]];
            [self highlightPoundKiloButtonFor: [settings lb_kg]];
        }
        //Defaults
        else {
            [self highlightWeekButtonForWeek: 1];
            [settings setWeek:1];
            
            [self highlightSetButtonForSet: 1];
            [settings setSet:1];
            
            [self highlightPoundKiloButtonFor: 0];
            [settings setLb_kg:0];
            
        }
    }
    
    [weightRepString setText: [settings weightRepString]];
    [self saveData];
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];

    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    maxInput.inputAccessoryView = keyboardDoneButtonView;
    
    
}

- (IBAction)doneClicked:(id)sender
{
    [weightRepString setText: @""];
    [self hideAllPlates];
    
    
    if (![maxInput.text isEqualToString:@"One Rep Max (lb)"]) {
            
            [settings setOneRepMax: [[maxInput text] intValue]];
            
            [settings calculateWeight];
            [settings calculateReps];
            
            [weightRepString setText: [settings weightRepString]];
            [self displayPlates];
    }
    
    [maxInput setText:[settings weightString]];
    
    [self saveData];
    
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}

-(void) saveData
{
    if ([savedInfo count] >= 18) {
        [savedInfo replaceObjectAtIndex:15 withObject:[NSNumber numberWithInteger: [settings week]]];
        [savedInfo replaceObjectAtIndex:16 withObject:[NSNumber numberWithInteger: [settings set]]];
        [savedInfo replaceObjectAtIndex:17 withObject:[NSNumber numberWithInteger: [settings lb_kg]]];
    }
    else {
        [savedInfo addObject: [NSNumber numberWithInteger: [settings week]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings set]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings lb_kg]]];
    }
    
    [NSKeyedArchiver archiveRootObject:savedInfo toFile: dataFilePath];
}

/*
 Displays the set information through a pop-up
 */

- (void) doubleTapSet:(id)sender
{
    NSString * title = @"Set Time Information";
    
    NSString * message = @"";
    NSString * set1String;
    NSString * set2String;
    NSString * set3String;
    
    
    
    if (set1Date != nil) {
        set1String = [NSString stringWithFormat:@"Set 1 -  %@\n", [dateFormatter stringFromDate:set1Date]];
    } else {
        set1String = @"Set 1 - \n";
    }
    
    if (set2Date != nil ) {
        set2String = [NSString stringWithFormat:@"Set 2 -  %@\n", [dateFormatter stringFromDate:set2Date]];

    } else {
        set2String = @"Set 2 - \n";
    }
    
    if (set3Date != nil ) {
        set3String = [NSString stringWithFormat:@"Set 3 -  %@\n", [dateFormatter stringFromDate:set3Date]];
        
    } else {
        set3String = @"Set 3 - \n";
    }

    NSLog(@"lastSet = %@", [dateFormatter stringFromDate:lastSet]);
    int timeSinceLastSet = [[NSDate date] timeIntervalSinceDate:lastSet];
    
    NSString * timeSinceLastSetString = [NSString stringWithFormat:@"Time Since Last Set -  %d seconds\n", timeSinceLastSet];
    
    message = [message stringByAppendingString:set1String];
    message = [message stringByAppendingString:set2String];
    message = [message stringByAppendingString:set3String];
    message = [message stringByAppendingString:timeSinceLastSetString];


    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

/*
 Called when a set button is clicked one, calls clickSet.  Waits 0.4 seconds to allow for a second tap
 */
- (void) touchDown:(id)sender
{
	// give it 0.4 sec for second touch
	[self performSelector:@selector(clickSet:) withObject:sender afterDelay:0.4];
}

/*
 Called when a set button is clicked twice, calls doubleTap set and cancels clickSet
 */
- (void) touchDownRepeat:(id)sender
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(clickSet:) object:sender];
	[self doubleTapSet:sender];
}







/*
 Function to hide the keyboard when the user is done entering input
 *//*
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    UITouch * touch = [[event allTouches] anyObject];
    if ([maxInput isFirstResponder] && [touch view] != maxInput) {
        
        [weightRepString setText: @""];
        [self hideAllPlates];

        
        [maxInput resignFirstResponder];
        
        
        [super touchesBegan:touches withEvent:event];
        
        if (![maxInput.text isEqualToString:@"One Rep Max (lb)"]) {
            
            [settings setOneRepMax: [[maxInput text] intValue]];
            
            [settings calculateWeight];
            [settings calculateReps];
            
            [weightRepString setText: [settings weightRepString]];
            [self displayPlates];

        
            [super touchesBegan:touches withEvent:event];
        }
    }
    
    [maxInput setText:[settings weightString]];
    
    [self saveData];
}*/






- (void) resignMaxInputFirstResponder {

    [maxInput resignFirstResponder];
    
    if ([maxInput.text isEqualToString:@""]) {
        maxInput.text = @"One Rep Max (lb)";
    }
}

//Display info pop-up on how to use this main lift view
- (IBAction)infoPushed:(id)sender {
    NSString * title = @"Main Lift Instructions";
    NSString * message = @"Enter your 1RM in pounds, 90 percent of this will be calculated before applying the percentage depending on the week and set selected.";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


/*
 Helper function to display the plates in kilos or pounds
 */
-(void) displayPlates
{
    if ([settings oneRepMax] > 0) {
        if ([settings lb_kg]) {
            [self displayKiloPlates];
        }
        else {
            [self displayPoundPlates];
        }
    }
}

/*
 Runs throguht the int * returned from myProgram's plateCount function and sets the plate labels to not hidden
 if need be and sets the labels for plates that multiple of are needed.  Example:  If 4 50kg plates are needed the 
 label will say 50kg x 4
 */
-(void) displayKiloPlates
{
    int * plates = [settings plateCounts];
    
    [self hideAllPlates];

    
    if (plates == NULL) {
        return;
    }
    
    float animationTime = 0.75;
    int plateOffset = 0;
    //int plateEndSpot = 515;
    int plateEndSpot;
    if (iPhone5) {
        plateEndSpot = (int)screenHeight - 110;
    } else {
        plateEndSpot = (int)recordLift.frame.origin.y - 20;
    }

//    int plateEndSpot = (int)screenHeight - 50;
    //int plateEndSpot = 410;
    float delay = 0.3;
    float gapBetweenPlates = 0.0;
    float halfPlateHeight;
    
    
    //Animate each plate
    if (plates[1] || plates[0])
    {
        //50 kg plates takes up to much space on smaller screens
        if ((plates[1] + 2*plates[0]) > 1) {
            kg25.text = [NSString stringWithFormat: @"25 x %i", plates[1] + 2*plates[0]];
        } else {
            kg25.text = @"25";
        }
        
        [self animatePlate: kg25 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        halfPlateHeight = (kg25.frame.size.height)/2;
        plateOffset += halfPlateHeight;
        
    }
    if (plates[2])
    {
        plateOffset += ((kg20.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: kg20 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((kg20.frame.size.height)/2);
    }
    if (plates[3])
    {
        plateOffset += ((kg15.frame.size.height)/2) + gapBetweenPlates;
        
        [self animatePlate: kg15 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((kg15.frame.size.height)/2);
    }
    if (plates[4])
    {
        plateOffset += ((kg10.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: kg10 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((kg10.frame.size.height)/2);
    }
    if (plates[5])
    {
        plateOffset += ((kg5.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: kg5 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((kg5.frame.size.height)/2);
    }
    if (plates[6])
    {
        plateOffset += ((kg2point5.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: kg2point5 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((kg2point5.frame.size.height)/2);
    }
    if (plates[7])
    {
        plateOffset += ((kg1point25.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: kg1point25 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((kg1point25.frame.size.height)/2);
    }
    if (plates[8])
    {
        plateOffset += ((kg0point5.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: kg0point5 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
//        animationTime *= 0.9;
//        plateOffset += ((kg0point5.frame.size.height)/2);
    }
    
    free(plates);
    
}

/*
 Runs throguht the int * returned from myProgram's plateCount function and sets the plate labels to not hidden
 if need be and sets the labels for plates that multiple of are needed.  Example:  If 4 45lb plates are needed the
 label will say 45lb x 4
 */
-(void) displayPoundPlates
{
    int * plates = [settings plateCounts];
    
    [self hideAllPlates];

    
    if (plates == NULL) {
        return;
    }
    
    float animationTime = 0.75;
    int plateOffset = 0;
    int plateEndSpot;
    if (iPhone5) {
        plateEndSpot = (int)screenHeight - 110;
    } else {
        plateEndSpot = (int)recordLift.frame.origin.y - 20;
    }

    // int plateEndSpot = 410;
    //int plateEndSpot = (int)screenHeight - 50;
    
    float delay = 0.0;
    float gapBetweenPlates = 0.0;
    float halfPlateHeight;
    
    
    //Display each plate
    if (plates[0])
    {
        if (plates[0] > 1) {
            lb45.text = [NSString stringWithFormat: @"45 x %i", plates[0]];
        } else {
            lb45.text = @"45";
        }
    
        [self animatePlate: lb45 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        halfPlateHeight = (lb45.frame.size.height)/2;
        plateOffset += halfPlateHeight;
    }
    
    if (plates[1])
    {
        plateOffset += ((lb25.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: lb25 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((lb25.frame.size.height)/2);
        
    }
    if (plates[2])
    {
        plateOffset += ((lb10.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: lb10 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((lb10.frame.size.height)/2);
        
    }
    if (plates[3])
    {
        plateOffset += ((lb5.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: lb5 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
        animationTime *= 0.9;
        plateOffset += ((lb5.frame.size.height)/2);
    }
    if (plates[4])
    {
        plateOffset += ((lb2point5.frame.size.height)/2) + gapBetweenPlates;
        [self animatePlate: lb2point5 forTime: animationTime withDelay: delay endingAt:plateEndSpot withOffset: plateOffset];
        
//        animationTime *= 0.9;
//        plateOffset += ((lb2point5.frame.size.height)/2);
    }
    
    free(plates);
}

/*
 Function to animate the individual plates
 */
- (void) animatePlate: (UILabel *) plate forTime: (float) animationTime withDelay: (float) delay endingAt:(int) plateEndSpot withOffset:(int) plateOffset {
    
    plate.center = CGPointMake(160, 343 + (plate.frame.size.height/2));
    plate.hidden = NO;
    
    CGPoint point = CGPointMake(160, plateEndSpot - plateOffset);
    
    [UIView animateWithDuration:animationTime delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        plate.center = point;
        
    }completion:^(BOOL feature){
    }];
}


/*
 Clears the users input when the 5/3/1 button is clicked, clears week, set, weight, plates displayed, and lbs or kilos
 */
- (IBAction)click531:(id)sender;
{
    [self resignMaxInputFirstResponder];
    
    [self hideAllPlates];

    
    [weightRepString setText: @""];
    [maxInput setText: @"One Rep Max (lb)" ];
    
    [self highlightPoundKiloButtonFor:0];
    [self highlightSetButtonForSet:1];
    [self highlightWeekButtonForWeek:1];
    
    [settings setWeek:1];
    [settings setSet:1];
    [settings setLb_kg:0];
    [settings setOneRepMax:0];
    
    set1Date = nil;
    set2Date = nil;
    set3Date = nil;
    
    [self saveData];
}

/*
 Called when the user clicks a week button, saves the week to the myProgram variable
 */
- (IBAction) clickWeek:(UIButton *) sender;
{
    [self resignMaxInputFirstResponder];
    
    [settings setOneRepMax:[maxInput.text intValue]];
    
    [self highlightWeekButtonForWeek:(int) sender.tag];
    
    [settings setWeek: (int)sender.tag];
    [settings calculateWeight];
    [settings calculateReps];
    
    [self displayWeightandReps];
    [self displayPlates];
    
    [self saveData];
    
}

/*
 Called when the user clicks a set button, saves the set to the myProgram variable
 */
- (IBAction) clickSet:(UIButton *) sender;
{
    switch ((int)sender.tag) {
        case 1:
            set1Date = [NSDate date];
            lastSet = set1Date;
            break;
        case 2:
            set2Date = [NSDate date];
            lastSet = set2Date;
            break;
        case 3:
            set3Date = [NSDate date];
            lastSet = set3Date;
            break;
        default:
            break;
    }
    
    
    [self resignMaxInputFirstResponder];
    
    [settings setOneRepMax:[maxInput.text intValue]];
    
    [self highlightSetButtonForSet:(int)sender.tag];
    
    [settings setSet: (int)sender.tag];
    
    [settings calculateWeight];
    [settings calculateReps];
    
    [self displayWeightandReps];
    [self displayPlates];
    
    [self saveData];
    
}

/*
 Called when the user clicks a pound or kiles button, saves the unit to the myProgram variable
 */
- (IBAction) clickPoundsKilos:(UIButton *) sender;
{
    [self resignMaxInputFirstResponder];
    [self hidePoundPlates];
    
    [settings setOneRepMax:[maxInput.text intValue]];
    
    [self highlightPoundKiloButtonFor: (int)sender.tag];
    
    [settings setLb_kg:(int)sender.tag];
    
    [settings calculateWeight];
    [settings calculateReps];
    
    [self displayWeightandReps];
    [self displayPlates];
    
    [self saveData];
    
}





/*
 Set the weight & rep string label
 */
-(void) displayWeightandReps
{
    [weightRepString setText: [settings weightRepString]];
}




- (void) highlightPoundKiloButtonFor: (int) lb_kg
{
    if (lb_kg) {
        [Kilos setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Pounds setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else {
        [Kilos setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [Pounds setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void) setPoundKiloButtonsToGray
{
    [Kilos setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Pounds setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void) highlightSetButtonForSet: (int) setNumber
{
    [self setAllSetButtonsToGray];
    [self setSetButtonToWhite: setNumber];
    
}

- (void) setSetButtonToWhite: (int) setNumber
{
    if (setNumber == 2) {
        [Set2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (setNumber == 3) {
        [Set3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else {
        [Set1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void) setAllSetButtonsToGray
{
    [Set1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Set2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Set3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void) highlightWeekButtonForWeek:(int) weekNumber {
    
    [self setAllWeekButtonsToGray];
    [self setWeekButtonToWhite: weekNumber];
}

- (void) setWeekButtonToWhite: (int) weekNumber {
    
    if (weekNumber == 2) {
        [Week2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (weekNumber == 3) {
        [Week3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if (weekNumber == 4) {
        [Week4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else {
        [Week1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void) setAllWeekButtonsToGray
{
    [Week1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Week2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Week3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Week4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

/*
 Hides both kilo and pound plates
 */
-(void) hideAllPlates {
    [self hideKiloPlates];
    [self hidePoundPlates];
}

/*
 Sets all pound plate labels to hidden
 */
-(void) hidePoundPlates
{
    lb45.hidden = YES;
    lb25.hidden = YES;
    lb10.hidden = YES;
    lb5.hidden = YES;
    lb2point5.hidden = YES;
}

/*
 Sets all kilo plate labels to hidden
 */
-(void) hideKiloPlates
{
    kg25.hidden = YES;
    kg20.hidden = YES;
    kg15.hidden = YES;
    kg10.hidden = YES;
    kg5.hidden = YES;
    kg2point5.hidden = YES;
    kg1point25.hidden = YES;
    kg0point5.hidden = YES;
}

/*
 No functionallity added to his function
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}

@end
