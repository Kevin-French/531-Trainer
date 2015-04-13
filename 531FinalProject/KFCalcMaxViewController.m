//
//  KFCalcMaxViewController.m
//  531withAssistance
//
//  Created by Kevin French on 1/29/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFCalcMaxViewController.h"
#import "KFMainLiftViewController.h"
#import "KF1RMCalculatorHelper.h"
#import "KFTools.h"

@interface KFCalcMaxViewController ()

@property (weak, nonatomic) IBOutlet UIButton *topTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomTypeButton;
@property (weak, nonatomic) IBOutlet UITextField *topTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *topUnitControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bottomUnitControl;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *resultsUnitControl;

@end

@implementation KFCalcMaxViewController {
    BOOL _repsUsed, _weightUsed, _maxUsed;
}

- (IBAction)resultUnitValueChanged:(id)sender {
    [self updateResultsString];
}

- (IBAction)topUnitControlValueChanged:(id)sender {
    [self updateResultsString];
}

- (IBAction)bottomUnitControlValueChanged:(id)sender {
    [self updateResultsString];
}

- (IBAction)topTypeButtonPressed:(id)sender {
    [self typeChangedForButton:self.topTypeButton];
    self.resultsLabel.text = @"";
}

- (IBAction)bottomTypeButtonPressed:(id)sender {
    [self typeChangedForButton:self.bottomTypeButton];
    self.resultsLabel.text = @"";
}

-(void)updateResultsString {
    
    int topValue = [self.topTextField.text intValue];
    int bottomValue = [self.bottomTextField.text intValue];
    
    if (self.topUnitControl.selectedSegmentIndex == 1) {
        topValue = [KFTools convertToPounds:topValue];
    }
    
    if (self.bottomUnitControl.selectedSegmentIndex == 1) {
        bottomValue = [KFTools convertToPounds:bottomValue];
    }
    
    int result = -1;
    
    if (_repsUsed && _weightUsed) {

        int reps = 0;
        int weight = 0;
        
        if ([self.topTypeButton.titleLabel.text isEqualToString:@"Reps"]) {
            reps = topValue;
            weight = bottomValue;
        } else {
            reps = bottomValue;
            weight = topValue;
        }
        
        result = [KF1RMCalculatorHelper calculateEstimateForWeightInLbs:weight reps:reps];
        
        if (self.resultsUnitControl.selectedSegmentIndex == 1) {
            result = [KFTools convertToKilos:result];
        }
        
        if (result > 0) {
            self.resultsLabel.text = [NSString stringWithFormat:@"Estimated Max: %d", result];
        } else {
            self.resultsLabel.text = @"";
        }

    } else if (_repsUsed && _maxUsed) {
        
        int reps = 0;
        int max = 0;
        
        if ([self.topTypeButton.titleLabel.text isEqualToString:@"Reps"]) {
            reps = topValue;
            max = bottomValue;
        } else {
            reps = bottomValue;
            max = topValue;
        }
        
        result = [KF1RMCalculatorHelper calculateWeightForRepsInLbs:reps max:max];
        
        if (self.resultsUnitControl.selectedSegmentIndex == 1) {
            result = [KFTools convertToKilos:result];
        }
        
        if (result > 0) {
            self.resultsLabel.text = [NSString stringWithFormat:@"Weight Needed: %d", result];
        } else {
            self.resultsLabel.text = @"";
        }
        

    } else if (_weightUsed && _maxUsed) {
        
        int weight = 0;
        int max = 0;
        
        if ([self.topTypeButton.titleLabel.text isEqualToString:@"Weight"]) {
            weight = topValue;
            max = bottomValue;
        } else {
            weight = bottomValue;
            max = topValue;
        }
        
        result = [KF1RMCalculatorHelper calculateRepsForWeightInLbs:weight max:max];
        
        if (result > 0) {
            self.resultsLabel.text = [NSString stringWithFormat:@"Reps Needed: %d", result];
        } else {
            self.resultsLabel.text = @"";
        }
    
    }
    
    
}

-(void)typeChangedForButton:(UIButton *) button {
    
    if (_repsUsed && _weightUsed) {
        if ([button.titleLabel.text isEqualToString:@"Reps"]) {
            _repsUsed = NO;
            _maxUsed = YES;
            _weightUsed = YES;
        } else {
            _weightUsed = NO;
            _maxUsed = YES;
            _repsUsed = YES;
        }
        
        [button setTitle:@"Max" forState:UIControlStateNormal];
        
        if (button == self.topTypeButton) {
            self.topUnitControl.hidden = NO;
        } else {
            self.bottomUnitControl.hidden = NO;
        }
        
    } else if (_repsUsed && _maxUsed) {
        if ([button.titleLabel.text isEqualToString:@"Reps"]) {
            _repsUsed = NO;
            _weightUsed = YES;
            _maxUsed = YES;
        } else {
            _maxUsed = NO;
            _weightUsed = YES;
            _repsUsed = YES;
        }
        
        [button setTitle:@"Weight" forState:UIControlStateNormal];
        
        if (button == self.topTypeButton) {
            self.topUnitControl.hidden = NO;
        } else {
            self.bottomUnitControl.hidden = NO;
        }
        
    } else if (_weightUsed && _maxUsed) {
        if ([button.titleLabel.text isEqualToString:@"Weight"]) {
            _weightUsed = NO;
            _repsUsed = YES;
            _maxUsed = YES;
        } else {
            _maxUsed = NO;
            _repsUsed = YES;
            _weightUsed = YES;
        }
        
        [button setTitle:@"Reps" forState:UIControlStateNormal];
        
        if (button == self.topTypeButton) {
            self.topUnitControl.hidden = YES;
        } else {
            self.bottomUnitControl.hidden = YES;
        }
    }
}

- (IBAction)clearPressed:(id)sender {
    self.topTextField.text = @"";
    self.bottomTextField.text = @"";
    self.resultsLabel.text = @"";
}

- (IBAction)calculatePressed:(id)sender {
    [self.view endEditing:YES];
    [self updateResultsString];
}



/*
 Creates a pop-up to explain how to use this view
 */
- (IBAction)infoPressed:(id)sender {
    
    NSString * title = @"1RM Calculator Info";
    NSString * message = @"Enter any combination of two from weight, reps and estimate in any combination of pounds and kilos to determine the third.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:NO];
    
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
    self.topTextField.inputAccessoryView = keyboardButtonsView;
    self.bottomTextField.inputAccessoryView = keyboardButtonsView;
    
    [self.topTypeButton setTitle:@"Weight" forState:UIControlStateNormal];
    [self.bottomTypeButton setTitle:@"Reps" forState:UIControlStateNormal];
    _weightUsed = YES;
    _repsUsed = YES;
    self.bottomUnitControl.hidden = YES;
    self.resultsLabel.text = @"";
    
    [self setBackground];
}

-(void)setBackground {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    UIColor * color1 = [UIColor colorWithRed:255.0/255.0 green:75.0/255.0 blue:0.0 alpha:1.0];
    UIColor * color2 = [UIColor colorWithRed:255.0/255.0 green:125.0/255.0 blue:0.0 alpha:1.0];
    NSArray * gradientColors = [NSArray arrayWithObjects:(id)[color2 CGColor], (id)[color1 CGColor], nil];
    gradient.colors = gradientColors;
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (IBAction)doneClicked:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)nextClicked:(id)sender
{
    if ([self.topTextField isEditing]) {
        [self.topTextField endEditing:YES];
        [self.bottomTextField becomeFirstResponder];
    }
    else if ([self.bottomTextField isEditing]) {
        [self.bottomTextField endEditing:YES];
        [self.topTextField becomeFirstResponder];
    }
}

@end