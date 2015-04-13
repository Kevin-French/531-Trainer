//
//  KFMainMenuViewController.m
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFMainMenuViewController.h"

@interface KFMainMenuViewController ()

@property (strong, nonatomic) IBOutlet UIButton *militaryPress, *deadLift, *benchPress, *squat;
@property KFMainMenuSettings * settings;
@property (strong, nonatomic) NSString * dataFilePath;
@property (strong, nonatomic) NSMutableArray * savedInfo;

@end

@implementation KFMainMenuViewController

@synthesize militaryPress, deadLift, benchPress, squat, savedInfo, settings, dataFilePath;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    //Hide navigation bar that may remain after record video view brought it up
    [self.navigationController setToolbarHidden:YES];
}

-(void) saveData
{
    //Save the selected lift to the phone
    if ([savedInfo count] >= 10) {
        [savedInfo replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger: settings.lastLiftSelected]];
    }
    else {
        [savedInfo addObject: [NSNumber numberWithInteger:settings.lastLiftSelected]];
    }
    
    [NSKeyedArchiver archiveRootObject:savedInfo toFile:dataFilePath];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    settings = [[KFMainMenuSettings alloc] init];
    
    
    //load saved settings
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docsDir = dirPaths[0];
    
    dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"/data.archive"]];
        
    if ([fm fileExistsAtPath:dataFilePath]) {
        NSLog(@"File Found");
        
        savedInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        
        //NSLog(@"%@", savedInfo);


        //Add one to last lift selected to make the highlighted lift be the next one
        if ([savedInfo count] >= 10) {
            int lastLiftSelected = [savedInfo[9] intValue];
            [settings setLastLiftSelected:((lastLiftSelected+1)%4)];
        }
        else {
            [settings setLastLiftSelected:(1+1)];
        }
        
        //Military Press
        if ([settings lastLiftSelected] == 1) {
            [militaryPress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [militaryPress setBackgroundColor:[UIColor whiteColor]];
        }
        //Deadlift
        else if ([settings lastLiftSelected] == 2) {
            [deadLift setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [deadLift setBackgroundColor:[UIColor whiteColor]];
        }
        //Bench Press
        else if ([settings lastLiftSelected] == 3) {
            [benchPress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [benchPress setBackgroundColor:[UIColor whiteColor]];
        }
        //Squat
        else {
            [squat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [squat setBackgroundColor:[UIColor whiteColor]];
        }
    } else {
        //Save defaults
        
        savedInfo = [[NSMutableArray alloc] init];
        
        [savedInfo addObject:[NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 1]];
        [savedInfo addObject: [NSNumber numberWithInteger: 5]];
        [savedInfo addObject: [NSNumber numberWithInteger: 5]];
        [savedInfo addObject: [NSNumber numberWithInteger: 5]];
        [savedInfo addObject: [NSNumber numberWithInteger: 5]]; //[8]
        
        [savedInfo addObject:[NSNumber numberWithInteger: 4]];
        
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]]; // [14]
        
        [savedInfo addObject: [NSNumber numberWithInteger: 1]];
        [savedInfo addObject: [NSNumber numberWithInteger: 1]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]]; //[17]
        
        [savedInfo addObject:[NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]];
        [savedInfo addObject: [NSNumber numberWithInteger: 0]]; // [22]
        
        [savedInfo addObject:@"No Movie"]; //[23]
    }
    
    [self addStyleToButton:militaryPress];
    [self addStyleToButton:deadLift];
    [self addStyleToButton:benchPress];
    [self addStyleToButton:squat];
    


    
    [self saveData];
}

-(void)addStyleToButton:(UIButton *)button {
    
    CALayer * layer = button.layer;
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.borderWidth = 1.0;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(3.0, 3.0);
    layer.masksToBounds = NO;
    layer.shadowOpacity = 1.0;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setBackground];
}

-(void)setBackground {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    UIColor * color1 = [UIColor colorWithRed:65.0/255 green:0 blue:1 alpha:1];
    UIColor * color2 = [UIColor colorWithRed:0 green:113.0/255.0 blue:1 alpha:1];
    NSArray * gradientColors = [NSArray arrayWithObjects:(id)[color2 CGColor], (id)[color1 CGColor], nil];
    gradient.colors = gradientColors;
    [self.view.layer insertSublayer:gradient atIndex:0];
}



-(IBAction)settingsPressed:(id)sender {
    [self performSegueWithIdentifier:@"SettingsSegue" sender:self];
}


- (IBAction) oneRepMaxCalculatorPressed:(id)sender {

    //Save settings before swtiching the oneRepMaxCalculator
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docsDir = dirPaths[0];
    
    dataFilePath = [docsDir stringByAppendingString:@"/data.archive"];
    
    if ([fm fileExistsAtPath:dataFilePath]) {
        savedInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        [self saveData];
    } else {
        NSLog(@"Something went wrong when trying to load the file in chooseLift");
    }
    
    [self performSegueWithIdentifier:@"OneRepMaxCalculatorSegue" sender:self];
}


/*
 Save selected list to phone before switching views
 */
- (IBAction)chooseLift:(UIButton *)sender {
    

    
    int selectedLift = (int)sender.tag;
    int selectedLiftIndex = selectedLift - 1;
    
    [settings setLastLiftSelected:selectedLift];
    
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docsDir = dirPaths[0];
    
    dataFilePath = [docsDir stringByAppendingString:@"/data.archive"];
    
    if ([fm fileExistsAtPath:dataFilePath]) {
        savedInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        
        //If choosing a new lift, set to set1
        if ([savedInfo[9] intValue] != selectedLift) {
            [savedInfo replaceObjectAtIndex:16 withObject:[NSNumber numberWithInteger: 1]];
            [savedInfo replaceObjectAtIndex:19 withObject:[NSNumber numberWithInteger: 0]];
            [savedInfo replaceObjectAtIndex:20 withObject:[NSNumber numberWithInteger: 0]];

        }
        
        [savedInfo replaceObjectAtIndex:18 withObject:[NSNumber numberWithInteger: [savedInfo[selectedLiftIndex] intValue]]];
        [self saveData];
    } else {
        NSLog(@"Something went wrong when trying to load the file in chooseLift");
    }
}




/*
 Info pop-up when info button is pressed
 */
- (IBAction)menuInfoPushed:(id)sender {
    NSString * title = @"Welcome";
    NSString * message = @"I made this app because I am a fan of Jim Wendler's 5/3/1 method and thought creating an app would enhance my time with his protocol.  I have no affiliation with Mr. Wendler and will remove this app if he requests such.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
