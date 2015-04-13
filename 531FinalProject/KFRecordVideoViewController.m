//
//  KFRecordVideoViewController.m
//  531
//
//  Created by Kevin French on 4/19/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//  Movie Player basics based on www.appcoda.com/video-recording-playback-ios-programming/

#import "KFRecordVideoViewController.h"

@interface KFRecordVideoViewController ()

@end

@implementation KFRecordVideoViewController
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    BOOL iPhone5;
}
@synthesize movie, movieController, dataFilePath, savedInfo, cycleNumber, lift, week, lb_kg, set, weightRepString;


-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:NO];
    
    self.movieController = [[MPMoviePlayerController alloc] initWithContentURL:self.movie];
    
    //Set up to not auto play, load video into player and repeat after being played
    [self.movieController setContentURL:movie];
    [movieController setShouldAutoplay: NO];
    [movieController prepareToPlay];
    [movieController setRepeatMode:MPMovieRepeatModeOne];
    
    //Set up size of movie player
    if (iPhone5) {
        [self.movieController.view setFrame:CGRectMake (0, 65, 320, 460)];
    } else {
        [self.movieController.view setFrame:CGRectMake (0, 65, 320, 374)];
    }
    
    
    [self.view addSubview:self.movieController.view];
    movieController.movieSourceType = MPMovieSourceTypeFile;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                                object:self.movieController];
}



/*
 Called when the movie finishes playing
 */
- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self.movieController stop];
    [self.movieController.view removeFromSuperview];
    self.movieController = nil;
    
    [self saveData];
}



- (void)shareVideo {

    
    
    NSString * string;
    NSString * liftString;

    //Get the and format the current date
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    //Check if the user is in a valid setup
    BOOL validCycle = cycleNumber > 0;
    BOOL validLift = (lift > 0 && lift < 5);
    BOOL validWeek = (week > 0 && week < 5);
    BOOL validSet = (set > 0 && set < 4);
    
    //If in a valid setup, structures the sharing string with the relevant information
    if (validCycle && validLift && validWeek && validSet) {
        
        if (lift == 1) {
            liftString = @"Military Press";
        } else if (lift == 2) {
            liftString = @"Deadlift";
        } else if (lift == 3) {
            liftString = @"Bench Press";
        } else {
            liftString = @"Squat";
        }
        
        string = [NSString stringWithFormat:@"5/3/1 (%@):  Cycle - %i, Week - %i\n%@ - %@\n", dateString, cycleNumber, week, liftString, weightRepString];
    } else {
        //Default string
        string = [NSString stringWithFormat:@"5/3/1(%@):  ", dateString];
    }
    
    
    //Url to eventually link to my app when sharing
    NSURL *appLink = [NSURL URLWithString:@"itms://itunes.com/apps/531Trainer"];
    
    NSArray * itemsToShare;
    if (movie != nil) {
        itemsToShare =  @[string, movie, appLink];
    } else {
        itemsToShare = @[string, appLink];
    }
    
    //Have the share view pop-up offering option to save video, message, email, etc.
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:itemsToShare
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}

/*
 Called when the share button is pushed.  Menu of sharing options appears
 */
- (IBAction)shareButtonPushed:(UIBarButtonItem *)sender {
    [self shareVideo];
}

/*
 Called when the camera button is pushed, opens camera for recording
 */
- (IBAction)cameraButtonPushed:(UIBarButtonItem *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

/*
 Called when the trach button is pushed.  Ask the user if they are sure they want to delete the current video
 before actually deleting it
 */
- (IBAction)trashButtonPushed:(UIBarButtonItem *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Delete Video?"];
    [alert setMessage:@"Are you sure you want to delete this video?"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
}


/*
 Calls the reset function if a reset is confirmed, otherwise does nothing
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //"Yes", reset confirmed
    if (buttonIndex == 0)
    {
        [self deleteMovie];
    }
}

/*
 Removes the current movie from the data saved to the phone
 */
-(void) deleteMovie {
    self.movie = nil;
    
    if ([savedInfo count] >= 24) {
        [savedInfo replaceObjectAtIndex:23 withObject:@"No Movie"];
    } else {
        [savedInfo addObject: @"No Movie"];
    }
    
    [NSKeyedArchiver archiveRootObject:savedInfo toFile: dataFilePath];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.movie = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


/*
 Saves data from this view to the phone if such a file already exists
 or creates on and saves if there is no such file yet
 */
-(void) saveData
{
    if (movie == nil) {
        return;
    }
    
    if ([savedInfo count] >= 24) {
        [savedInfo replaceObjectAtIndex:23 withObject:movie];
    } else {
        [savedInfo addObject: movie];
    }
    
    [NSKeyedArchiver archiveRootObject:savedInfo toFile: dataFilePath];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setToolbarHidden:NO];
    
    
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

    
    NSFileManager * fm;
    NSString * docsDir;
    NSArray * dirPaths;
    
    fm = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"/data.archive"]];
    
    //Load relevant information to display in the share string
    if ([fm fileExistsAtPath:dataFilePath]) {
        savedInfo = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        NSLog(@"%@", savedInfo);
        NSLog(@"Here");
        cycleNumber = [savedInfo[4] intValue];
        lift = [savedInfo[9] intValue];
        week = [savedInfo[15] intValue];
        lb_kg = [savedInfo[17] intValue];
        set = [savedInfo[16] intValue];
        if ([savedInfo[23] isKindOfClass:[NSURL class]]) {
            movie = savedInfo[23];
        } else {
            movie = nil;
        }

    } else { //Set default info for sharing string
        cycleNumber = 0;
        lift = 0;
        week = 0;
        lb_kg = 0;
        set = 0;
        movie = nil;

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [movieController stop];
    [self saveData];
}


/*
 Display a pop-up of text about how to use this view
 */
- (IBAction)infoPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Record Lift Info"];
    [alert setMessage:@"To record a lift press the camera button below.  If you wish to keep the video after it has been recorded make sure to save or share it"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Ok"];

//    [alert addButtonWithTitle:@"Yes"];
//    [alert addButtonWithTitle:@"No"];
    [alert show];
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
@end
