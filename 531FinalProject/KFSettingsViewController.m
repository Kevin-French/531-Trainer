//
//  KFSettingsViewController.m
//  531
//
//  Created by Kevin French on 4/11/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFSettingsViewController.h"
#import "CGRectObject.h"
#import "LiftSettingsCollectionViewCell.h"
#import "CycleCollectionViewCell.h"


@interface KFSettingsViewController () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *militaryPressLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadliftLabel;
@property (weak, nonatomic) IBOutlet UILabel *benchPressLabel;
@property (weak, nonatomic) IBOutlet UILabel *squatLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation KFSettingsViewController {
    NSArray * _militaryPressPositions;
    NSArray * _deadliftPositions;
    NSArray * _benchPressPositions;
    NSArray * _squatPositions;
    NSArray * _cyclePositions;
    
    CGPoint _topLabelCenter;
    CGPoint _topTextFieldCenter;
    CGPoint _topButtonCenter;
}
@synthesize militaryPressIncrement, squatIncrement, benchPressIncrement, deadLiftIncrement, militaryPressInput, squatInput, deadLiftInput, benchPressInput, cycleInput, nextCycle, settings, savedInfo;

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row == 0) {
        
        LiftSettingsCollectionViewCell * c = (LiftSettingsCollectionViewCell *) cell;
        c.liftLabel.text = @"Military Press";
        c.weightLabel.text = [settings militaryPressString];
        c.incrementAmountLabel.text = [NSString stringWithFormat:@"%lu", [settings incrementMilitaryPressPerCycle]];
        
    } else if (indexPath.row == 1) {
    
        LiftSettingsCollectionViewCell * c = (LiftSettingsCollectionViewCell *) cell;
        c.liftLabel.text = @"Deadlift";
        c.weightLabel.text = [settings deadLiftString];
        c.incrementAmountLabel.text = [NSString stringWithFormat:@"%lu", [settings incrementDeadLiftPerCycle]];
        
    } else if (indexPath.row == 2) {

        LiftSettingsCollectionViewCell * c = (LiftSettingsCollectionViewCell *) cell;
        c.liftLabel.text = @"Bench Press";
        c.weightLabel.text = [settings benchPressString];
        c.incrementAmountLabel.text = [NSString stringWithFormat:@"%lu", [settings incrementBenchPressPerCycle]];
    } else if (indexPath.row == 3) {
        
        LiftSettingsCollectionViewCell * c = (LiftSettingsCollectionViewCell *) cell;
        c.liftLabel.text = @"Squat";
        c.weightLabel.text = [settings squatString];
        c.incrementAmountLabel.text = [NSString stringWithFormat:@"%lu", [settings incrementSquatPerCycle]];
        
    } else if (indexPath.row == 4) {
        
        CycleCollectionViewCell * c = (CycleCollectionViewCell *) cell;
        c.mainLabel.text = @"Cycle";
        c.subLabel.text = [settings cycleString];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1 && indexPath.section == 1) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"cycleCell" forIndexPath:indexPath];
    } else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"liftCell" forIndexPath:indexPath];
    }
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self moveObjectsToTopWithTag:textField.tag];
    
    return YES;
}

-(void)moveObjectsToTopWithTag:(NSInteger)tag {
    
    for (UIView * view in self.view.subviews) {
        if (view.tag == tag) {
            
            CGRect rect = view.frame;
            CGFloat x = rect.origin.x;
            CGFloat y = rect.origin.y + 100;
            CGFloat w = rect.size.width;
            CGFloat h = rect.size.height;
            
            [UIView animateWithDuration:0.25 animations:^{
                view.frame = CGRectMake(x, y, w, h);
            }];
        }
    }
}

- (IBAction)doneClicked:(id)sender
{
    [self stripInputs];
    [militaryPressInput setText: [settings militaryPressString]];
    [deadLiftInput setText: [settings deadLiftString]];
    [benchPressInput setText: [settings benchPressString]];
    [squatInput setText: [settings squatString]];
    [cycleInput setText: [settings cycleString]];
    
    [self saveData];
    
    [self.view endEditing:YES];
    
    [self resetBackToInitialPositions];

}

- (IBAction)nextClicked:(id)sender
{
    if ([militaryPressInput isEditing]) {
        [militaryPressInput endEditing:YES];
        [deadLiftInput becomeFirstResponder];
    }
    else if ([deadLiftInput isEditing]) {
        [deadLiftInput endEditing:YES];
        [benchPressInput becomeFirstResponder];
    }
    else if ([benchPressInput isEditing]) {
        [benchPressInput endEditing:YES];
        [squatInput becomeFirstResponder];
    }
    else if ([squatInput isEditing]) {
        [squatInput endEditing:YES];
        [cycleInput becomeFirstResponder];
    }
    else if ([cycleInput isEditing]) {
        [cycleInput endEditing:YES];
        [militaryPressInput becomeFirstResponder];
    }
}






/*
 Gets all the inputs from the max fields and saves them to the settings object
 */
- (void) stripInputs
{
    int mp = [[militaryPressInput text] intValue];
    int dl = [[deadLiftInput text] intValue];
    int bp = [[benchPressInput text] intValue];
    int s = [[squatInput text] intValue];
    int c = [[cycleInput text] intValue];
    
    if (mp > 0) {
        [settings setMilitaryPressMax:mp];
    }
    if (dl > 0) {
        [settings setDeadLiftMax:dl];
    }
    if (bp > 0) {
        [settings setBenchPressMax:bp];
    }
    if (s > 0) {
        [settings setSquatMax:s];
    }
    if (c > 0) {
        [settings setCycle:c];
    }

    [self saveData];
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self saveData];
}

/*
 Saves data to file overwriting existing data if such exists
 */
-(void) saveData
{
    if ([savedInfo count] >= 9) {
        [savedInfo replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger: [settings militaryPressMax]]];
        [savedInfo replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger: [settings deadLiftMax]]];
        [savedInfo replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger: [settings benchPressMax]]];
        [savedInfo replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger: [settings squatMax]]];
        [savedInfo replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger: [settings cycle]]];
        [savedInfo replaceObjectAtIndex:5 withObject:[NSNumber numberWithInteger: [settings incrementMilitaryPressPerCycle]]];
        [savedInfo replaceObjectAtIndex:6 withObject:[NSNumber numberWithInteger: [settings incrementDeadLiftPerCycle]]];
        [savedInfo replaceObjectAtIndex:7 withObject:[NSNumber numberWithInteger: [settings incrementBenchPressPerCycle]]];
        [savedInfo replaceObjectAtIndex:8 withObject:[NSNumber numberWithInteger: [settings incrementSquatPerCycle]]];

    } else {
        [savedInfo addObject: [NSNumber numberWithInteger: [settings militaryPressMax]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings deadLiftMax]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings benchPressMax]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings squatMax]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings cycle]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings incrementMilitaryPressPerCycle]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings incrementDeadLiftPerCycle]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings incrementBenchPressPerCycle]]];
        [savedInfo addObject: [NSNumber numberWithInteger: [settings incrementSquatPerCycle]]];
    }


    [NSKeyedArchiver archiveRootObject:savedInfo toFile: _dataFilePath];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    [self.navigationController setToolbarHidden:YES];
    
    _militaryPressPositions = [NSArray arrayWithObjects:[[CGRectObject alloc] initWithRect:self.militaryPressLabel.frame], [[CGRectObject alloc] initWithRect:self.militaryPressInput.frame], [[CGRectObject alloc] initWithRect:self.militaryPressIncrement.frame], nil];
    _deadliftPositions = [NSArray arrayWithObjects:[[CGRectObject alloc] initWithRect:self.deadliftLabel.frame], [[CGRectObject alloc] initWithRect:self.deadLiftInput.frame], [[CGRectObject alloc] initWithRect:self.deadLiftIncrement.frame], nil];;
    _benchPressPositions = [NSArray arrayWithObjects:[[CGRectObject alloc] initWithRect:self.benchPressLabel.frame], [[CGRectObject alloc] initWithRect:self.benchPressInput.frame], [[CGRectObject alloc] initWithRect:self.benchPressIncrement.frame], nil];;
    _squatPositions = [NSArray arrayWithObjects:[[CGRectObject alloc] initWithRect:self.squatLabel.frame], [[CGRectObject alloc] initWithRect:self.squatInput.frame], [[CGRectObject alloc] initWithRect:self.squatIncrement.frame], nil];;
    _cyclePositions = [NSArray arrayWithObjects:[[CGRectObject alloc] initWithRect:self.cycleLabel.frame], [[CGRectObject alloc] initWithRect:self.cycleInput.frame], [[CGRectObject alloc] initWithRect:self.nextCycle.frame], nil];
    
    _topLabelCenter = self.militaryPressLabel.center;
    _topTextFieldCenter = militaryPressInput.center;
    _topButtonCenter = militaryPressIncrement.center;
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 150, self.view.frame.size.width, 100);
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setBackground];
}

-(void)setBackground {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    UIColor * color1 = [UIColor colorWithRed:1 green:1 blue:50.0/255.0 alpha:1];
    UIColor * color2 = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    NSArray * gradientColors = [NSArray arrayWithObjects:(id)[color2 CGColor], (id)[color1 CGColor], nil];
    gradient.colors = gradientColors;
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setToolbarHidden:YES];

    
    settings = [[KFSettings alloc] init];

	// Do any additional setup after loading the view.
    
    NSFileManager * fm;
    NSString * docsDir;
    NSArray * dirPaths;
    
    fm = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];

    
    _dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"/data.archive"]];

    
    //Load file and use appropraite information to construct this view or use defaults to do so
    //if not file exists
    if ([fm fileExistsAtPath:_dataFilePath]) {
        
        savedInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: _dataFilePath];
        
        [settings setMilitaryPressMax:[savedInfo[0] intValue]];
        [militaryPressInput setText:[settings militaryPressString]];
        
        [settings setDeadLiftMax:[savedInfo[1] intValue]];
        [deadLiftInput setText:[settings deadLiftString]];
        
        [settings setBenchPressMax:[savedInfo[2] intValue]];
        [benchPressInput setText:[settings benchPressString]];
        
        [settings setSquatMax:[savedInfo[3] intValue]];
        [squatInput setText:[settings squatString]];
        
        [settings setCycle:[savedInfo[4] intValue]];
        [cycleInput setText:[settings cycleString]];

        if ([savedInfo count] >= 9) {
            if ([savedInfo[5] intValue] == 5) {
                [militaryPressIncrement setTitle:@"+5" forState:UIControlStateNormal];
                [settings setIncrementMilitaryPressPerCycle: 5];
            }
            else {
                [militaryPressIncrement setTitle:@"+10" forState:UIControlStateNormal];
                [settings setIncrementMilitaryPressPerCycle: 10];
            }
            
            if ([savedInfo[6] intValue] == 5) {
                [deadLiftIncrement setTitle:@"+5" forState:UIControlStateNormal];
                [settings setIncrementDeadLiftPerCycle: 5];
            }
            else {
                [deadLiftIncrement setTitle:@"+10" forState:UIControlStateNormal];
                [settings setIncrementDeadLiftPerCycle: 10];
            }

            
            if ([savedInfo[7] intValue] == 5) {
                [benchPressIncrement setTitle:@"+5" forState:UIControlStateNormal];
                [settings setIncrementBenchPressPerCycle: 5];

            }
            else {
                [benchPressIncrement setTitle:@"+10" forState:UIControlStateNormal];
                [settings setIncrementBenchPressPerCycle: 10];
            }

            
            if ([savedInfo[8] intValue] == 5) {
                [squatIncrement setTitle:@"+5" forState:UIControlStateNormal];
                [settings setIncrementSquatPerCycle: 5];

            }
            else {
                [squatIncrement setTitle:@"+10" forState:UIControlStateNormal];
                [settings setIncrementSquatPerCycle: 10];

            }
        }
    }
    else {
        [settings setIncrementMilitaryPressPerCycle:5];
        [settings setIncrementDeadLiftPerCycle:5];
        [settings setIncrementBenchPressPerCycle:5];
        [settings setIncrementSquatPerCycle:5];
        
        [settings setMilitaryPressMax:0];
        [settings setDeadLiftMax:0];
        [settings setBenchPressMax:0];
        [settings setSquatMax:0];
        [settings setCycle:0];
    }
    
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
    
    militaryPressInput.inputAccessoryView = keyboardButtonsView;
    deadLiftInput.inputAccessoryView = keyboardButtonsView;
    benchPressInput.inputAccessoryView = keyboardButtonsView;
    squatInput.inputAccessoryView = keyboardButtonsView;
    cycleInput.inputAccessoryView = keyboardButtonsView;
    
    militaryPressInput.delegate = self;
    deadLiftInput.delegate = self;
    benchPressInput.delegate = self;
    squatInput.delegate = self;
    cycleInput.delegate = self;
}

-(void)resetBackToInitialPositions {
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        
//        self.militaryPressLabel.frame = [[_militaryPressPositions objectAtIndex:0] CGRectFromObject];
//        self.militaryPressInput.frame = [[_militaryPressPositions objectAtIndex:1] CGRectFromObject];
//        self.militaryPressIncrement.frame = [[_militaryPressPositions objectAtIndex:2] CGRectFromObject];
//        self.militaryPressLabel.alpha = 1.0;
//        self.militaryPressInput.alpha = 1.0;
//        self.militaryPressIncrement.alpha = 1.0;
////        self.militaryPressLabel.hidden = NO;
////        self.militaryPressInput.hidden = NO;
////        self.militaryPressIncrement.hidden = NO;
//        
//        
//        self.deadliftLabel.frame = [[_deadliftPositions objectAtIndex:0] CGRectFromObject];
//        self.deadLiftInput.frame = [[_deadliftPositions objectAtIndex:1] CGRectFromObject];
//        self.deadLiftIncrement.frame = [[_deadliftPositions objectAtIndex:2] CGRectFromObject];
//        self.deadliftLabel.alpha = 1.0;
//        self.deadLiftInput.alpha = 1.0;
//        self.deadLiftIncrement.alpha = 1.0;
////        self.deadliftLabel.hidden = NO;
////        self.deadLiftInput.hidden = NO;
////        self.deadLiftIncrement.hidden = NO;
//        
//        self.benchPressLabel.frame = [[_benchPressPositions objectAtIndex:0] CGRectFromObject];
//        self.benchPressInput.frame = [[_benchPressPositions objectAtIndex:1] CGRectFromObject];
//        self.benchPressIncrement.frame = [[_benchPressPositions objectAtIndex:2] CGRectFromObject];
//        self.benchPressLabel.alpha = 1.0;
//        self.benchPressInput.alpha = 1.0;
//        self.benchPressIncrement.alpha = 1.0;
////        self.benchPressLabel.hidden = NO;
////        self.benchPressInput.hidden = NO;
////        self.benchPressIncrement.hidden = NO;
//        
//        self.squatLabel.frame = [[_squatPositions objectAtIndex:0] CGRectFromObject];
//        self.squatInput.frame = [[_squatPositions objectAtIndex:1] CGRectFromObject];
//        self.squatIncrement.frame = [[_squatPositions objectAtIndex:2] CGRectFromObject];
//        self.squatLabel.alpha = 1.0;
//        self.squatInput.alpha = 1.0;
//        self.squatIncrement.alpha = 1.0;
////        self.squatLabel.hidden = NO;
////        self.squatInput.hidden = NO;
////        self.squatIncrement.hidden = NO;
//        
//        self.cycleLabel.frame = [[_cyclePositions objectAtIndex:0] CGRectFromObject];
//        self.cycleInput.frame = [[_cyclePositions objectAtIndex:1] CGRectFromObject];
//        self.nextCycle.frame = [[_cyclePositions objectAtIndex:2] CGRectFromObject];
//        self.cycleLabel.alpha = 1.0;
//        self.cycleInput.alpha = 1.0;
//        self.nextCycle.alpha = 1.0;
////        self.cycleLabel.hidden = NO;
////        self.cycleInput.hidden = NO;
////        self.nextCycle.hidden = NO;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Creates a pop-up explaining how to use this view
 */
- (IBAction)infoPressed:(id)sender {
    
    NSString * title = @"Saved Program Info";
    NSString * message = @"Enter 100% of your max weight for each lift in pounds and the cycle number you are currently on.  Hitting next cycle will add 5 or 10 pounds to each lift and add 1 to the cycle number.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


/*
Asks the user if they are sure that want to clear all of their settings 
 */
- (IBAction)pushed531:(id)sender {
    
    [militaryPressInput resignFirstResponder];
    [deadLiftInput resignFirstResponder];
    [benchPressInput resignFirstResponder];
    [squatInput resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Clear Saved Info?"];
    [alert setMessage:@"Are you sure you want to clear your saved program info?  Doing so will erase all of your inputed maxes and the cyle number.  The video of your last lift will not be erased."];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
    
}

/*
 Changes the displayed increment amount in the button and saves this change in the settings
 */
- (IBAction)militaryPressIncrementPressed:(id)sender {
    if ([settings incrementMilitaryPressPerCycle] == 5) {
        [militaryPressIncrement setTitle:@"+10" forState:UIControlStateNormal];
        [settings setIncrementMilitaryPressPerCycle: 10];
    } else {
        [militaryPressIncrement setTitle:@"+5" forState:UIControlStateNormal];
        [settings setIncrementMilitaryPressPerCycle: 5];
    }
    
    [self saveData];
}


/*
 Changes the displayed increment amount in the button and saves this change in the settings
 */
- (IBAction)deadLiftIcrementPressed:(id)sender {
    
    if ([settings incrementDeadLiftPerCycle] == 5) {
        [deadLiftIncrement setTitle:@"+10" forState:UIControlStateNormal];
        [settings setIncrementDeadLiftPerCycle: 10];
    } else {
        [deadLiftIncrement setTitle:@"+5" forState:UIControlStateNormal];
        [settings setIncrementDeadLiftPerCycle: 5];
    }
    
    [self saveData];
}

/*
 Changes the displayed increment amount in the button and saves this change in the settings
 */
- (IBAction)benchPressIncrementPressed:(id)sender {
    
    if ([settings incrementBenchPressPerCycle] == 5) {
        [benchPressIncrement setTitle:@"+10" forState:UIControlStateNormal];
        [settings setIncrementBenchPressPerCycle: 10];
    } else {
        [benchPressIncrement setTitle:@"+5" forState:UIControlStateNormal];
        [settings setIncrementBenchPressPerCycle: 5];
    }
    
    [self saveData];
}

/*
 Changes the displayed increment amount in the button and saves this change in the settings
 */
- (IBAction)squatIncrementPressed:(id)sender {
    
    if ([settings incrementSquatPerCycle] == 5) {
        [squatIncrement setTitle:@"+10" forState:UIControlStateNormal];
        [settings setIncrementSquatPerCycle: 10];
        
    } else {
        [squatIncrement setTitle:@"+5" forState:UIControlStateNormal];
        [settings setIncrementSquatPerCycle: 5];
    }
    
    [self saveData];
}

/*
 Increments all the lifts by their individual increment amounts and increments the cycle by 1
 */
- (IBAction)cycleIncrementPressed:(id)sender {
    
    [settings incrementCycle];
    [militaryPressInput setText: [settings militaryPressString]];
    [deadLiftInput setText: [settings deadLiftString]];
    [benchPressInput setText: [settings benchPressString]];
    [squatInput setText: [settings squatString]];
    [cycleInput setText: [settings cycleString]];
    
    [savedInfo replaceObjectAtIndex:15 withObject:[NSNumber numberWithInteger: 1]];
    [savedInfo replaceObjectAtIndex:16 withObject:[NSNumber numberWithInteger: 1]];
    
    [self saveData];
}

/*
 Calls the reset function if a reset is confirmed, otherwise does nothing
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //"Yes", reset confirmed
    if (buttonIndex == 0)
    {
        [self reset];
    }
}

/*
 Called after a reset is confirmed.  Clears the saved file and resets all the values in it to their defaults.
 Also resets the inputed maxes and their strings as well as the corresponding fields in the settings object
 */
-(void)reset
{
    [settings setIncrementMilitaryPressPerCycle:5];
    [settings setIncrementDeadLiftPerCycle:5];
    [settings setIncrementBenchPressPerCycle:5];
    [settings setIncrementSquatPerCycle:5];

    [settings setMilitaryPressMax:0];
    [settings setDeadLiftMax:0];
    [settings setBenchPressMax:0];
    [settings setSquatMax:0];
    [settings setCycle:0];

    [benchPressIncrement setTitle:@"+5" forState:UIControlStateNormal];
    [militaryPressIncrement setTitle:@"+5" forState:UIControlStateNormal];
    [squatIncrement setTitle:@"+5" forState:UIControlStateNormal];
    [deadLiftIncrement setTitle:@"+5" forState:UIControlStateNormal];
    
    [militaryPressInput setText:@"-"];
    [deadLiftInput setText:@"-"];
    [benchPressInput setText:@"-"];
    [squatInput setText:@"-"];
    [cycleInput setText:@"-"];
    
    
    [savedInfo replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:5 withObject:[NSNumber numberWithInteger: 5]];
    [savedInfo replaceObjectAtIndex:6 withObject:[NSNumber numberWithInteger: 5]];
    [savedInfo replaceObjectAtIndex:7 withObject:[NSNumber numberWithInteger: 5]];
    [savedInfo replaceObjectAtIndex:8 withObject:[NSNumber numberWithInteger: 5]];
    [savedInfo replaceObjectAtIndex:9 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:10 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:11 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:12 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:13 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:14 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:15 withObject:[NSNumber numberWithInteger: 1]];
    [savedInfo replaceObjectAtIndex:16 withObject:[NSNumber numberWithInteger: 1]];
    [savedInfo replaceObjectAtIndex:17 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:18 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:19 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:20 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:21 withObject:[NSNumber numberWithInteger: 0]];
    [savedInfo replaceObjectAtIndex:22 withObject:[NSNumber numberWithInteger: 0]];
    
    [NSKeyedArchiver archiveRootObject:savedInfo toFile: _dataFilePath];
}

@end
