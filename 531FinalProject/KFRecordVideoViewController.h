//
//  KFRecordVideoViewController.h
//  531
//
//  Created by Kevin French on 4/19/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface KFRecordVideoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)infoPressed:(id)sender;

@property (copy,   nonatomic) NSURL *movie;
@property (strong, nonatomic) MPMoviePlayerController *movieController;
@property NSString * dataFilePath;
@property NSMutableArray * savedInfo;
@property int cycleNumber, lift, week, lb_kg, set;
@property NSString * weightRepString;
- (IBAction)shareButtonPushed:(UIBarButtonItem *)sender;
- (IBAction)cameraButtonPushed:(UIBarButtonItem *)sender;
- (IBAction)trashButtonPushed:(UIBarButtonItem *)sender;

@end
