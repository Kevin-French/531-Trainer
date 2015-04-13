//
//  KFAssistanceCalculatorViewController.m
//  531withAssistance
//
//  Created by Kevin French on 2/1/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFAssistanceCalculatorViewController.h"

@interface KFAssistanceCalculatorViewController ()

@end

@implementation KFAssistanceCalculatorViewController

@synthesize weight, percent, weightForSet, weightPoundsUnitButton, weightKilosUnitButton, weightForSetPoundsUnitButton, weightForSetKilosUnitButton, dataFilePath, settings, savedInfo;
/*
 Used to close the keyboard when the used is done entering inputs.
 Checks to see if combination of inputs are valid and updates view accordingly
 *//*
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    UITouch * touch = [[event allTouches] anyObject];
    if ([weight isFirstResponder] && [touch view] != weight) {
        
        [weight resignFirstResponder];
        
        [self stripInputs];
        
        [settings setOtherUnitWeights];
        [weight setText:[settings weightString]];
        [percent setText:[settings percentString]];
        [weightForSet setText:[settings weightForSetString]];
        
        [weight resignFirstResponder];
        [super touchesBegan:touches withEvent:event];
    }
    
    else if ([percent isFirstResponder] && [touch view] != percent) {
        
        [percent resignFirstResponder];
        
        [self stripInputs];

        [settings setOtherUnitWeights];
        [weight setText:[settings weightString]];
        [percent setText:[settings percentString]];
        [weightForSet setText:[settings weightForSetString]];
        
        [percent resignFirstResponder];
        [super touchesBegan:touches withEvent:event];
    }
    
    else if ([weightForSet isFirstResponder] && [touch view] != weightForSet) {
        
        [weightForSet resignFirstResponder];
        
        [self stripInputs];
        
        [settings setOtherUnitWeights];
        [weight setText:[settings weightString]];
        [percent setText:[settings percentString]];
        [weightForSet setText:[settings weightForSetString]];
        [weightForSet resignFirstResponder];
        
        [super touchesBegan:touches withEvent:event];
    }
    
    [self saveData];
}*/


- (IBAction)doneClicked:(id)sender
{
    [self stripInputs];
        
    [settings setOtherUnitWeights];
    [weight setText:[settings weightString]];
    [percent setText:[settings percentString]];
    [weightForSet setText:[settings weightForSetString]];
    
    [self saveData];
    [self.view endEditing:YES];
    
}

- (IBAction)nextClicked:(id)sender
{
    if ([weight isEditing]) {
        [weight endEditing:YES];
        [percent becomeFirstResponder];
    }
    else if ([percent isEditing]) {
        [percent endEditing:YES];
        [weight becomeFirstResponder];
    }
}

/*
 Takes the values from all of the inputs and updates the settings object
 */
- (void) stripInputs {
    
    [settings setWeight: [[weight text] intValue]];
    [settings setPercent: [[percent text] intValue]];
    [settings setWeightForSet: [[weightForSet text] intValue]];
}

/*
 Highlights the appropraite unit button for weight and does any needed conversions
 */
- (IBAction)clickPoundsKilosForWeight:(UIButton *)sender
{
    
    if ([settings weight_lb_kg] == [sender tag]) {
        return;
    }
    
    [settings weightConverted];
    //[weight setText:[settings weightString]];
    
    [weight setText:[settings weightString]];
    
    
    
    [settings setWeight_lb_kg:(int)sender.tag];
    [self highlightPoundKiloWeightButtonFor:(int)sender.tag];
    
    [self saveData];
}


/*
 Highlights the appropraite unit button for weight for set and does any needed conversions
 */
- (IBAction)clickPoundsKilosForWeightForSet:(UIButton *)sender
{
    if ([settings weightForSet_lb_kg] == [sender tag]) {
        return;
    }

    [settings weightForSetConverted];
    
   // [weightForSet setText:[settings weightForSetString]];
    
    if ([settings weight] > 0 && [settings percent] > 0) {
        [weightForSet setText:[NSString stringWithFormat:@"%i", [settings weightForSet]]];
    } else {
        [weightForSet setText:[settings weightForSetString]];
    }
    
    [settings setWeightForSet_lb_kg:(int)sender.tag];
    [self highlightPoundKiloWeightForSetButtonFor:(int)sender.tag];

    [self saveData];
}


/*
 Creates a pop-up with instructions on how to use this view
 */
- (IBAction)infoPressed:(id)sender {
    
    NSString * title = @"Assistance Work Info";
    NSString * message = @"Enter the weight and percentage of that weight you would like to use for a set.  Pounds and kilos in any combination can be choosen for the weight entered and the outputed weight for the set.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

/*
 No functionality added
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 Saves all the settings to the phone, overwriting if necessary
 */
-(void) saveData
{
    if ([savedInfo count] >= 23) {
        [savedInfo replaceObjectAtIndex:18 withObject:[NSNumber numberWithInteger: [settings weight]]];
        [savedInfo replaceObjectAtIndex:19 withObject:[NSNumber numberWithInteger: [settings percent]]];
        [savedInfo replaceObjectAtIndex:20 withObject:[NSNumber numberWithInteger: [settings weightForSet]]];
        [savedInfo replaceObjectAtIndex:21 withObject:[NSNumber numberWithInteger: [settings weight_lb_kg]]];
        [savedInfo replaceObjectAtIndex:22 withObject:[NSNumber numberWithInteger: [settings weightForSet_lb_kg]]];

    }
    else {
        [savedInfo addObject: [NSNumber numberWithInteger: [settings weight]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings percent]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings weightForSet]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings weight_lb_kg]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings weightForSet_lb_kg]]];

    }
    
    [NSKeyedArchiver archiveRootObject:savedInfo toFile:dataFilePath];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    [self.navigationController setToolbarHidden:YES];
    
    [settings setOtherUnitWeights];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController setToolbarHidden:YES];
  
    settings = [[KFAssistanceSettings alloc] init];
    
    //Load saved settings if they exist, defaults otherwise
    NSFileManager * fm;
    NSString * docsDir;
    NSArray * dirPaths;
    
    fm = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"/data.archive"]];
    
    if ([fm fileExistsAtPath:dataFilePath]) {
        savedInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        
        if ([savedInfo count] >= 23) {
            int savedWeight = [savedInfo[18] intValue];
            [settings setWeight: savedWeight];
            
            int savedPercent = [savedInfo[19] intValue];
            [settings setPercent:savedPercent];
            
            int savedWeightForSet = [savedInfo[20] intValue];
            [settings setWeightForSet:savedWeightForSet];
            
            int saved_lb_kg_weight = [savedInfo[21] intValue];
            [settings setWeight_lb_kg:saved_lb_kg_weight];
            
            int saved_lb_kg_weightForSet = [savedInfo[22] intValue];
            [self highlightPoundKiloWeightForSetButtonFor: saved_lb_kg_weightForSet];
        }
        
    } else {
        [settings setWeight:0];
        [settings setPercent:0];
        [settings setWeightForSet:0];
        [settings setWeight_lb_kg:0];
        [settings setWeightForSet_lb_kg:0];
    }
    
    [weight setText:[settings weightString]];
    [percent setText:[settings percentString]];
    [weightForSet setText:[settings weightForSetString]];
    [self highlightPoundKiloWeightButtonFor: [settings weight_lb_kg]];
    [self highlightPoundKiloWeightForSetButtonFor: [settings weightForSet_lb_kg]];
    
    [settings setOtherUnitWeights];
    

    [self saveData];
    
    
    UIToolbar* keyboardButtonsView = [[UIToolbar alloc] init];
    [keyboardButtonsView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem* nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(nextClicked:)];
    
    
    [keyboardButtonsView setItems:[NSArray arrayWithObjects:doneButton, flexibleItem, nextButton, nil]];
    
    percent.inputAccessoryView = keyboardButtonsView;
    weight.inputAccessoryView = keyboardButtonsView;
    weightForSet.inputAccessoryView = keyboardButtonsView;
    
    [weightForSet setUserInteractionEnabled:NO];
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}

/*
 Highlights the appropraite unit button for weight when one of them is pushed
 */
- (void) highlightPoundKiloWeightButtonFor: (int) lb_kg
{
    [self setPoundKiloWeightButtonsToGray];
    
    
    
    if (lb_kg) {
        [weightKilosUnitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [weightPoundsUnitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

/*
 Highlights the appropraite unit button for weight for set when one of them is pushed
 */
- (void) highlightPoundKiloWeightForSetButtonFor: (int) lb_kg
{
    [self setPoundKiloWeightForSetButtonsToGray];
    
    if (lb_kg) {
        [weightForSetKilosUnitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [weightForSetPoundsUnitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


/*
Sets both unit buttons to gray for weight
 */
- (void) setPoundKiloWeightButtonsToGray
{
    [weightKilosUnitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [weightPoundsUnitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}


/*
 Sets both unit buttons to gray for weight for set
 */
- (void) setPoundKiloWeightForSetButtonsToGray
{
    [weightForSetKilosUnitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [weightForSetPoundsUnitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

/*
 No functionality added here
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDefaultInputStrings {
    [weight setText:@"Weight"];
    [percent setText:@"Percent"];
    [weightForSet setText:@"Weight For Set"];
}

/*
 Resets the view when the 5/3/1 button is clicked
 */
- (IBAction)clear531:(id)sender {
    
    [self setDefaultInputStrings];
    
    [settings setWeight:0];
    [settings setPercent:0];
    [settings setWeightForSet:0];

    [settings setWeightForSet_lb_kg:0];
    [settings setWeight_lb_kg:0];
    
    [settings setOtherUnitWeightForSet:0];
    [settings setOtherUnitWeight:0];
    
    [self highlightPoundKiloWeightForSetButtonFor:0];
    [self highlightPoundKiloWeightButtonFor:0];
    
    [self saveData];

}

@end