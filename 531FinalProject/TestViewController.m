//
//  TestViewController.m
//  531 Trainer
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import "TestViewController.h"
#import "FlatUIKit.h"

@interface TestViewController ()

@end

@implementation TestViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    
    
    CGFloat x = 50;
    CGFloat y = 50;
    CGFloat width = 50;
    CGFloat height = 50;
    
    FUISegmentedControl * mySegmentedControl = [[FUISegmentedControl alloc] initWithItems:@[@"Title 1", @"Title 2", @"Title 3"]];
    mySegmentedControl.frame = CGRectMake(x, y, width, height);
    
    [self.view addSubview:mySegmentedControl];
    
    mySegmentedControl.selectedFont = [UIFont boldFlatFontOfSize:16];
    mySegmentedControl.selectedFontColor = [UIColor cloudsColor];
    mySegmentedControl.deselectedFont = [UIFont flatFontOfSize:16];
    mySegmentedControl.deselectedFontColor = [UIColor cloudsColor];
    mySegmentedControl.selectedColor = [UIColor amethystColor];
    mySegmentedControl.deselectedColor = [UIColor silverColor];
    mySegmentedControl.dividerColor = [UIColor midnightBlueColor];
    mySegmentedControl.cornerRadius = 5.0;
    
    
}


@end
