//
//  HomeViewController.m
//  HeartBeatz
//  HomeViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import "UIDeviceHardware.h"
#import "HomeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
int countertimer = 0;
int counterLap = 0;
int BpmMusicPlayedCounter;
BOOL BeingPlayed;
@interface HomeViewController ()

@property (strong, nonatomic) NSMutableArray *runArray;

@end

@implementation HomeViewController
@synthesize musicPlayer;
-(void)viewDidLoad{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

    //checks watch connection every 3 seconds
    //_timermethod = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(Watchconnectioncheck) userInfo:nil repeats:YES];

    // [self.MusicBeingPlayedLabel setHidden:YES];
    // [self.MusicPlayed setHidden:YES];
    
    self.MusicPlayed.hidden = YES;
    self.MusicBeingPlayedLabel.hidden = YES;

    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];

    BpmMusicPlayedCounter = 0;
    BeingPlayed = NO;
    NSUserDefaults *Def = [NSUserDefaults standardUserDefaults];
    NSString *Ver = [Def stringForKey:@"Version"];
    NSString *CurVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    if(Ver == nil || [Ver compare:CurVer] != 0)
    {
        if(Ver == nil)
        {
            
        }
        //Run once-per-upgrade code, if any
        [Def setObject:CurVer forKey:@"Version"];
    }
            NSLog(@"hitoncethatsaboutit");
    
            _Removetipview = YES;
            [self Setuptip];
    
            self.lastPageButton= [UIButton buttonWithType:UIButtonTypeSystem];
            // [self.lastPageButton setBackgroundImage:[UIImage imageNamed:@"Forward.png"]
            // forState:UIControlStateNormal];
            self.lastPageButton.backgroundColor = [UIColor colorWithRed:70.f/255.f green:130.f/255.f blue:180.f/255.f alpha:1.f];
            self.lastPageButton.layer.cornerRadius = 5.f;
            _lastPageButton.tintColor = [UIColor whiteColor];
            [self.lastPageButton addTarget:self
                                    action:@selector(Viewdelete)
                          forControlEvents:UIControlEventTouchUpInside];
            [self.lastPageButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
            [self.lastPageButton.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS" size:18.0]];
            self.lastPageButton.frame = CGRectMake(40, 40, 33.0, 33.0);
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.cornerRadius = 5.f;
            
            [button addTarget:self
                       action:@selector(Viewdelete)
             forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor colorWithRed:70.f/255.f green:130.f/255.f blue:180.f/255.f alpha:1.f];
            
            [button setTitle:@"Skip" forState:UIControlStateNormal];
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        button.frame = CGRectMake(95,685, 220, 40.0);

    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        NSLog(@"iphonxishit");
        button.frame = CGRectMake(75,680, 220, 40.0);
    }
    else
    {
        button.frame = CGRectMake(78,610, 220, 40.0);

    }


            NSArray *pageContentArray = @[@{kNDIntroPageTitle : @"HeartBeatz",
                                            kNDIntroPageDescription : @"Please sync or pair to Apple iWatch to continue.",
                                            kNDIntroPageImageName : @"Applewatch"
                                            },
                                          @{kNDIntroPageTitle : @"Welcome",
                                            kNDIntroPageDescription : @"Welcome to HeartBeatz, an iOS application that syncs the music from your favorite playlist to the rate of your heart beat. Feeling punmped? So will your music!",
                                           // kNDIntroPageImageName : @"workitout"
                                            },
                                          @{kNDIntroPageTitle : @"Heart Rate",
                                            kNDIntroPageDescription : @"During a workout, measure your calories, fat and carbohydates, burned. Keep track of workouts by steps taken, distance and beats per minute(BPM).",
                                            kNDIntroPageImageName : @"Heartrate"
                                            },
                                          @{kNDIntroPageTitle : @"Music Playlist",
                                            kNDIntroPageDescription : @"Select music from your library and set your favorite playlist to your heart beat. Personalize your workout music to match your intensity! Work harder, play harder and control your mood!",
                                            kNDIntroPageImageName : @"MusicFolder"
                                            },
                                          @{kNDIntroPageTitle : @"Enjoy your workout",
                                            kNDIntroPageDescription : @"Profile created!",
                                            kNDIntroPageImageName : @"profile",
                                            
                                            
                                            }
                                          ];
            self.introView = [[NDIntroView alloc] initWithFrame:self.view.frame parallaxImage:[UIImage imageNamed:@"parallaxBgImage"] andData:pageContentArray];
            self.introView.delegate = self;
            [self.introView addSubview:button];
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.introView];
     

    if ([WCSession isSupported]) {
        self.Session = [WCSession defaultSession];
        self.Session.delegate = self;
        [self.Session activateSession];
    }
    
    //watch is reachable or not.. here we can send a alert view, to connect watch
    if ([[WCSession defaultSession] isReachable]) {
        NSLog(@"recachedwatch");
    }
    else{
        NSLog(@"not reached watch");
    }
    
    
    /*
    NSObject * object = [defaults objectForKey:@"MusicMedia"];
    if(object != nil){
        //object is there
       
    }
    else
    {
        _BPMButton.hidden = YES;
        _BPMButton.enabled = NO;
        _BPMButton.alpha = 0;
        NSLog(@"hasbpmsongs");
    }
  */
 

    [[HealthKitManager sharedManager] requestAuthorization];
    
    self.runArray = [[RunHelper new] retrieveAllObjects];
    [self setUpView];
    [self setUpGestures];
    [super viewDidLoad];
    musicPlayer = [MPMusicPlayerController applicationMusicPlayer];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideTipView)];
    [self.view addGestureRecognizer:gestureRecognizer];
    self.view.userInteractionEnabled = YES;
    gestureRecognizer.cancelsTouchesInView = NO;  // this prevents the gesture recognizers to 'block' touches
}
- (BOOL)prefersStatusBarHidden {
    
    return NO;
}
-(void)Watchconnectioncheck
{
    
    
    //we are here,
    // 1. we had to update apple watch
   // 2. check if the below code is working, issupported and is reachable
       // 3. test if reachable code is working
    //4. addd uiview with activity indicator and message please connect iwatch
    //5. view is removed when watch is reachable
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
        NSLog(@"SESSION AVAIBLE");
    }
    else
    {
        NSLog(@"SESSION notAVAIBLE");

    }
    
    //Objective-C
    if ([[WCSession defaultSession] isReachable]) {
        NSLog(@"SESSION REACHABLE");
        [_timermethod invalidate];
        _timermethod = nil;
    }
    else
    {
        NSLog(@"SESSION notREACHABLE");

    }
        
}
- (NSTimer *)createTimer {
    return [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(timerTicked:)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)timerTicked:(NSTimer *)timer {
    
    _currentTimeInSeconds++;
    
    self.stopwatchTimeLabel.text = [self formattedTime:_currentTimeInSeconds];
    
}

- (NSString *)formattedTime:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}
- (void)PauseFromWatch
{
    [_myTimer invalidate];
    _myTimer = nil;
    
    if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
    {
        
        [controller pause];
        
    }
}
-(void)StartFromWatch
{
    if (!_currentTimeInSeconds) {
        _currentTimeInSeconds = 0 ;
    }
    
    if (!_myTimer) {
        _myTimer = [self createTimer];
    }
    
}
-(void)StopFromWatch
{
    [_myTimer invalidate];
    _myTimer = nil;
    
    if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
    {
        
        [controller pause];
        
    }
}
- (IBAction)BPMPlaylistMainscreen:(id)sender;
{
    NSString *platform = [UIDeviceHardware platform];
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboard" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
        
        
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboardiphoneX" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
        
        
    }
    else
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboardsmalliphone" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
}
- (IBAction)MusicSelectionMainScreen:(id)sender;
{
    CLMediaPicker *picker = [[CLMediaPicker alloc] init];
    picker.mediaTypes = CLMediaPickerAll;
    picker.delegate = self;
    picker.allowsPickingMultipleItems = YES;
    picker.showsCloudItems = NO;
    picker.isModal = YES;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:picker];
    [self presentViewController:navController animated:YES completion:nil];

}
- (IBAction)PauseButtonPressed:(id)sender;
{
    [_myTimer invalidate];
    _myTimer = nil;
    
    NSString *StopString = @"Pause";
    
    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[StopString] forKeys:@[@"PausePhoneToWatchWorkout"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];

    if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
    {

        [controller pause];

    }
   // [self.StopButton setHidden:NO];
   // [self.StartButton setHidden:NO];
   // [self.PauseButton setHidden:YES];

}
- (IBAction)startButtonPressed:(id)sender;
{
    startDate = [NSDate date];
    counterLap++;
    
    NSString *str = [@(counterLap) stringValue];
    _LapLabel.text= str;
    
    
    

    
    [_LapLabel setNeedsDisplay];
    
    if (!_currentTimeInSeconds) {
        _currentTimeInSeconds = 0 ;
    }
    
    if (!_myTimer) {
        _myTimer = [self createTimer];
    }
    
    NSString *StopString = @"START";

    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[StopString] forKeys:@[@"StartPhoneToWatchWorkout"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];

    
    NSString *LapNum = str;
    
    NSString *Lap = @"LAP,";
    
    NSString *LapCounter = [Lap stringByAppendingString:LapNum];

    
    
    NSDictionary *applicationData3 = [[NSDictionary alloc] initWithObjects:@[LapCounter] forKeys:@[@"LapLabelValuetoWatch"]];
    
    [[WCSession defaultSession] sendMessage:applicationData3
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    
    //[self.StartButton setHidden:YES];
    //[self.StopButton setHidden:NO];
//[self.PauseButton setHidden:NO];
    
    /* steps conuter
    [self.pedometer startPedometerUpdatesFromDate:[NSDate dateWithTimeIntervalSinceNow:0]  withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        // this block is called for each live update
        [self updateLabels:pedometerData];
        
    }];
     */

}

- (IBAction)stopButtonPressed:(id)sender;
{
     [_myTimer invalidate];
      _myTimer = nil;
   
    
    NSString *StopString = @"STOP";
    
 
    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[StopString] forKeys:@[@"StopPhoneToWatchWorkout"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    
    if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
    {
        
        [controller pause];
        
    }
   // [self.StartButton setHidden:NO];
   // [self.PauseButton setHidden:YES];
  //  [self.StartButton setHidden:NO];

}

- (void)updateLabels:(CMPedometerData *)pedometerData {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.maximumFractionDigits = 2;
    
    // step counting
    if ([CMPedometer isStepCountingAvailable]) {
        self.Labelheart.text = [NSString stringWithFormat:@"Steps walked: %@", [formatter stringFromNumber:pedometerData.numberOfSteps]];
    } else {
        self.Labelheart.text = @"Step Counter not available.";
    }
}
-(void)Setuptip
{
    if (_Removetipview == YES)
    {
    tooltip = [[JDFTooltipView alloc] initWithTargetView:self.Label23 hostView:self.view tooltipText:@"Select Media through settings, to add music into the BPM Playlist." arrowDirection:JDFTooltipViewArrowDirectionUp width:200.0f];
    [tooltip show];
    }
}
-(void)HideTipView
{
    if (_Removetipview == YES)
    {
        [tooltip hide];
        _Removetipview = NO;
    }

}
-(void)viewWillAppear:(BOOL)animated{
    
    self.MapWidth.constant = [[UIScreen mainScreen] bounds].size.width;
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.map.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.010;
    mapRegion.span.longitudeDelta = 0.010;
    [self.map setRegion:mapRegion animated:YES];
    
    [super viewWillAppear:YES];
}
-(void)Viewdelete
{
    NSLog(@"delted");
    [UIView animateWithDuration:0.7f animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
    
}
-(void)setUpView{
    
    float distance = 0.00;
    int INT = 0;
    for (int i = 0; i < self.runArray.count; i++) {
        Run *run = [self.runArray objectAtIndex:i];
        distance = distance + [run.distance intValue];
        INT = i;
    }
    //self.totalDistance.text = [NSString stringWithFormat:@"%@", [MathController stringifyDistance:distance]];
    self.totalRuns.text = [NSString stringWithFormat:@"%i", INT + 1];
}

-(void)setUpGestures{
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:1 animations:^{
            self.MapWidth.constant = [[UIScreen mainScreen] bounds].size.width;
            [self.view layoutIfNeeded];
        }];
        
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        
        [UIView animateWithDuration:1 animations:^{
            self.MapWidth.constant = 0;
            [self.view layoutIfNeeded];
        }];
    }
}

-(IBAction)showMenu:(id)sender{
   
    if (_Removetipview == YES)
    {
        [tooltip hide];
        _Removetipview = NO;
    }

    [kMainViewController showLeftViewAnimated:YES completionHandler:nil];
}
-(IBAction)MediaforApp:(id)sender{
    
    CLMediaPicker *picker = [[CLMediaPicker alloc] init];
    picker.mediaTypes = CLMediaPickerAll;
    picker.delegate = self;
    picker.allowsPickingMultipleItems = YES;
    picker.showsCloudItems = NO;
    picker.isModal = YES;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:picker];
    [self presentViewController:navController animated:YES completion:nil];
    
    
    
 
}
-(IBAction)BPMbutton:(id)sender{
    NSString *platform = [UIDeviceHardware platform];
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboard" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboardiphoneX" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboardsmalliphone" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark - CLMediaPickerDelegate

- (void)clMediaPicker:(CLMediaPicker *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    if (mediaItemCollection)
    {
        _BPMButton.hidden = NO;
        _BPMButton.enabled = YES;
        _BPMButton.alpha = 1;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        NSString *mediaedit = @"mediaedit";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
       
        [defaults setObject:mediaedit forKey:@"MusicEdit"];
        [defaults setObject:data forKey:@"MusicMedia"];
        [defaults synchronize];

        if (mediaItemCollection)
        {
            NSArray *items = [mediaItemCollection items];
            for( int n=0; n < items.count; n++ )    {
                MPMediaItem *mediaItem = [items objectAtIndex:n];
             //   NSLog(@"%@=========>",[mediaItem valueForProperty:MPMediaItemPropertyTitle]);
            }
        }
        NSLog(@"info");
        // Do what you want with the collection
        //NSLog(@"currentItem = %@", [mediaItemCollection valueForProperty:MPMediaItemPropertyTitle]);
        
        // NSLog (@"Your Array elements are = %@", mediaItemCollection);
        // Specify a media query; this one matches the entire library because it
        // does not contain a media property predicate
        MPMediaQuery *everything = [[MPMediaQuery alloc] init];
        
        // Configure the media query to group its media items; here, grouped by artist
        [everything setGroupingType: MPMediaGroupingTitle];
        
        // Obtain the media item collections from the query
        NSArray *collections = [everything collections];
       // NSLog (@"Your Array elements are = %@", collections);
        
    }
}
- (CMPedometer *)pedometer {
    
    if (!pedometer) {
        pedometer = [[CMPedometer alloc]init];
    }
    return pedometer;
}
- (void)clMediaPickerDidDonePicking:(CLMediaPicker *)mediaPicker
{
    [self dismissViewControllerAnimated:NO completion:nil];
  
    NSString *platform = [UIDeviceHardware platform];
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboard" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
        
        
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboardiphoneX" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
        
        
    }
    else
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMViewStoryboardsmalliphone" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMViewController"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
    
}

- (void)clMediaPickerDidCancel:(CLMediaPicker *)mediaPicker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - WCSession Delegate
/*- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
    
    NSString *counterValue = [message objectForKey:@"counterValue"];
    
    NSLog(@"currentItem = %@", counterValue);

    //Use this to update the UI instantaneously (otherwise, takes a little while)
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    });
}*/


- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
    NSString *counterValue = [message objectForKey:@"counterValue2"];
    NSString *TimerString = [message objectForKey:@"StartTimerWatch"];
    NSString *PauseTimerString = [message objectForKey:@"PauseTimerPhone"];
    NSString *StopTimerString = [message objectForKey:@"StopTimerPhone"];

  //  if (!self.counterData) {
       // self.counterData = [[NSMutableArray alloc] init];
   // }
    
    //Use this to update the UI instantaneously (otherwise, takes a little while)
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //[self.counterData addObject:counterValue];
       // [self.mainTableView reloadData];

        //NSString *test = @"teststring";
        [self showLog:counterValue];
       [self StartTimerFromWatch:TimerString];
        [self PauseTimerFromWatch:PauseTimerString];
        [self StopTimerFromWatch:StopTimerString];

    });
}
- (void)StopTimerFromWatch:(NSString*)StopTimerString{
    
    if([StopTimerString containsString:@"ST"])
    {
        [self StopFromWatch];
        [self.StartButton setHidden:NO];
        [self.PauseButton setHidden:NO];


    }
}
- (void)PauseTimerFromWatch:(NSString*)PauseTimerString{
    
    if([PauseTimerString containsString:@"ON"])
    {
        [self PauseFromWatch];
        [self.StopButton setHidden:NO];
        [self.StartButton setHidden:NO];
        [self.PauseButton setHidden:NO];
        
    }
}
- (void)StartTimerFromWatch:(NSString*)TimerString{
    
    if([TimerString containsString:@"ES"])
    {
        [self StartFromWatch];
        [self.StartButton setHidden:NO];
        [self.StopButton setHidden:NO];
        [self.PauseButton setHidden:NO];
        
  

    }
    //for the start and pause button juss over lap them and hide the pause button in viewdidload

    
}
- (IBAction)LapIncreaseLabelMethod:(id)sender;
{
    //try to get time stamp from timer when lap is pressed. -> could be the solution NSTimeInterval or try to start then stop timer but in the process get the timer value...
    //NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:startDate];
   //  timeInterval += _timeElapsed;
   // NSLog(@"%@",timeInterval); // 5:26
    //startDate = [NSDate date];
    self.LastLap.text = [self formattedTime:_currentTimeInSeconds];
    
    
    //// to set label to 2 becuase of lap and then increase integer by counter for lap when user selects lap button..
    counterLap++;
    
    NSString *str = [@(counterLap) stringValue];
    _LapLabel.text= str;



    [_LapLabel setNeedsDisplay];
    
}
- (void)showLog:(NSString*)HeartBeat{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    

    
    if ([HeartBeat intValue] > 68 && [HeartBeat intValue] < 79) {

        if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
        {
            NSLog(@"yes  Sound is on");
            if (BpmMusicPlayedCounter == 5)
            {
                self.Labelheart.text = HeartBeat;
                
                ///alertview to change bpm to high or lower depending the latest heartbeat comming in, if selected yes set bpmcounter to 0 and
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"HeartBeatz" message:@"Change BPM Playlist? " preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    [self BPMChangedMethod:HeartBeat];
                    // Ok action example
                }];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    // Other action
                    [self AlertviewNO];
                }];
                [alert addAction:okAction];
                [alert addAction:otherAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
        else
        {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM1"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        }
    }
    else if([HeartBeat intValue] > 80 && [HeartBeat intValue] < 97)
    {
        if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
        {
            NSLog(@"yes  Sound is on");
            if (BpmMusicPlayedCounter == 5)
            {
                self.Labelheart.text = HeartBeat;
                
                ///alertview to change bpm to high or lower depending the latest heartbeat comming in, if selected yes set bpmcounter to 0 and
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"HeartBeatz" message:@"Change BPM Playlist? " preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    [self BPMChangedMethod:HeartBeat];
                    // Ok action example
                }];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    // Other action
                    [self AlertviewNO];
                }];
                [alert addAction:okAction];
                [alert addAction:otherAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
        else
        {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM2"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
     }
    }
    else if([HeartBeat intValue] > 98 && [HeartBeat intValue] < 109)
    {
        if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
        {
            NSLog(@"yes  Sound is on");
            if (BpmMusicPlayedCounter == 5)
            {
                self.Labelheart.text = HeartBeat;
                
                ///alertview to change bpm to high or lower depending the latest heartbeat comming in, if selected yes set bpmcounter to 0 and
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"HeartBeatz" message:@"Change BPM Playlist? " preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    [self BPMChangedMethod:HeartBeat];
                    // Ok action example
                }];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    // Other action
                    [self AlertviewNO];
                }];
                [alert addAction:okAction];
                [alert addAction:otherAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
        else
        {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM3"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        }
    }
    else if([HeartBeat intValue] > 110 && [HeartBeat intValue] < 130)
    {
        self.Labelheart.text = HeartBeat;
       
        /* another way to check if music is being played or not.. 
        if(BeingPlayed == YES)
        {
            
        }
        else
        {
            
        }
        */
        if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
        {
            NSLog(@"yes  Sound is on");
             if (BpmMusicPlayedCounter == 5)
             {
                 self.Labelheart.text = HeartBeat;

                 ///alertview to change bpm to high or lower depending the latest heartbeat comming in, if selected yes set bpmcounter to 0 and
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"HeartBeatz" message:@"Change BPM Playlist? " preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                     [self BPMChangedMethod:HeartBeat];
                     // Ok action example
                 }];
                 UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                     // Other action
                     [self AlertviewNO];
                 }];
                 [alert addAction:okAction];
                 [alert addAction:otherAction];
                 [self presentViewController:alert animated:YES completion:nil];
             
             }
        }
        else
        {
            NSLog(@"NO  Sound is not on");
            NSData *data = [defaults objectForKey:@"MusicMediaBPM4"];
            MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
            
            //Plays with ios system..
            controller = [MPMusicPlayerController applicationMusicPlayer];
            //systemMusicPlayer
            //  Plays with in the ios App
            //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
            
            
            MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
            MPMediaItem *item = [collection representativeItem];
            
            [controller setQueueWithItemCollection:collection];
            [controller setNowPlayingItem:item];
            
            // MPMediaItem  *songItem = [controller nowPlayingItem];
            //NSLog (@"%@", songItem);
            
            NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
            [notificationCenter addObserver:self
                                   selector:@selector(handleNowPlayingItemChanged:)
                                       name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                     object:controller];
            
            [notificationCenter addObserver:self
                                   selector:@selector(handlePlaybackStateChanged:)
                                       name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                     object:controller];
            [notificationCenter addObserver:self
                                   selector:@selector(handleExternalVolumeChanged:)
                                       name:MPMusicPlayerControllerVolumeDidChangeNotification
                                     object:controller];
            
            [controller beginGeneratingPlaybackNotifications];
            
            [self PlayMusic];

        }
        
           }
    else if([HeartBeat intValue] > 131 && [HeartBeat intValue] < 210)
    {
        self.Labelheart.text = HeartBeat;
        if ([[MPMusicPlayerController applicationMusicPlayer] playbackState] == MPMusicPlaybackStatePlaying)
        {
            NSLog(@"yes  Sound is on");
            if (BpmMusicPlayedCounter == 5)
            {
                self.Labelheart.text = HeartBeat;
                
                ///alertview to change bpm to high or lower depending the latest heartbeat comming in, if selected yes set bpmcounter to 0 and
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"HeartBeatz" message:@"Change BPM Playlist? " preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    [self BPMChangedMethod:HeartBeat];
                    // Ok action example
                }];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    // Other action
                    [self AlertviewNO];
                }];
                [alert addAction:okAction];
                [alert addAction:otherAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
        else
        {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM5"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
    
    }
    }
}

-(void)BPMChangedMethod:(NSString*)HeartBeat
{
    NSLog(@"hitalertbpm");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if(BpmMusicPlayedCounter == 5)
    {
        BpmMusicPlayedCounter = 0;
    }
    
    if ([HeartBeat intValue] > 68 && [HeartBeat intValue] < 79) {
        
        NSData *data = [defaults objectForKey:@"MusicMediaBPM1"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        
    }
    else if([HeartBeat intValue] > 80 && [HeartBeat intValue] < 97)
    {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM2"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
    }
    else if([HeartBeat intValue] > 98 && [HeartBeat intValue] < 109)
    {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM3"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
    }
    else if([HeartBeat intValue] > 110 && [HeartBeat intValue] < 130)
    {
        self.Labelheart.text = HeartBeat;
        
            NSLog(@"NO  Sound is not on");
            NSData *data = [defaults objectForKey:@"MusicMediaBPM4"];
            MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
            
            //Plays with ios system..
            controller = [MPMusicPlayerController applicationMusicPlayer];
            //systemMusicPlayer
            //  Plays with in the ios App
            //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
            
            
            MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
            MPMediaItem *item = [collection representativeItem];
            
            [controller setQueueWithItemCollection:collection];
            [controller setNowPlayingItem:item];
            
            // MPMediaItem  *songItem = [controller nowPlayingItem];
            //NSLog (@"%@", songItem);
            
            NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
            [notificationCenter addObserver:self
                                   selector:@selector(handleNowPlayingItemChanged:)
                                       name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                     object:controller];
            
            [notificationCenter addObserver:self
                                   selector:@selector(handlePlaybackStateChanged:)
                                       name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                     object:controller];
            [notificationCenter addObserver:self
                                   selector:@selector(handleExternalVolumeChanged:)
                                       name:MPMusicPlayerControllerVolumeDidChangeNotification
                                     object:controller];
            
            [controller beginGeneratingPlaybackNotifications];
            
            [self PlayMusic];
        
    }
    else if([HeartBeat intValue] > 131 && [HeartBeat intValue] < 210)
    {
        self.Labelheart.text = HeartBeat;
        
        NSData *data = [defaults objectForKey:@"MusicMediaBPM5"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        
    }

    
    
    
    
    
    
}
-(void)AlertviewNO
{

    BpmMusicPlayedCounter = 0;
}
-(void)StopPauseMusic
{
    [controller pause];
    BeingPlayed = NO;
}
-(void)PlayMusic
{
    NSLog(@"Playmusic");
    
    [controller prepareToPlay];
    [controller play];
    [controller currentPlaybackTime];
    BeingPlayed = YES;
    NSLog (@"%f",  [controller currentPlaybackTime]);
}
-(void)handleNowPlayingItemChanged:(id)notification {
    NSLog(@"nextsongnotification");
    // [MusicPlayerView setHidden:YES];
    //[MusicPlayerView setAlpha:0];
    // MPMusicPlayerController *player = (MPMusicPlayerController *)notification;
    
    BpmMusicPlayedCounter++;
    BeingPlayed = YES;
    
    MPMediaItem *song = [controller nowPlayingItem];
    
    if (song) {
        NSString *title = [song valueForProperty:MPMediaItemPropertyTitle];
        NSString *album = [song valueForProperty:MPMediaItemPropertyAlbumTitle];
        NSString *artist = [song valueForProperty:MPMediaItemPropertyArtist];
        NSString *playCount = [song valueForProperty:MPMediaItemPropertyPlayCount];
        
        //multiple
        //NSMutableDictionary *dic = [NSMutableDictionary dictionary];
       // [dic setValue:@"nvjd" forKey:@"name"];
        NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[title] forKeys:@[@"ArtistNameWatch"]];
        
        [[WCSession defaultSession] sendMessage:applicationData2
                                   replyHandler:^(NSDictionary *reply) {
                                       //handle reply from iPhone app here
                                   }
                                   errorHandler:^(NSError *error) {
                                       //catch any errors here
                                   }
         ];
        
        // NSLog(@"title: %@", title);
        //  NSLog(@"album: %@", album);
        //  NSLog(@"artist: %@", artist);
        // NSLog(@"playCount: %@", playCount);
        
        MPMediaItemArtwork *artwork = [song valueForProperty: MPMediaItemPropertyArtwork];
        
        if(artwork){
            //    imageView.image = [artwork imageWithSize:imageView.frame.size];
            NSLog(@"hasimagenotification");
           // MusicImagine =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
           // MusicImagine.image= [artwork imageWithSize:MusicImagine.frame.size];
            
        }
        else
        {
            NSLog(@"noimagenotification");
          //  MusicImagine =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
           // MusicImagine.image=[UIImage imageNamed:@"Music.png"];
            
        }
        
        }
}
- (void)handlePlaybackStateChanged:(id)notification {
    NSLog(@"pause and play");
}
- (void)handleExternalVolumeChanged:(id)notification {
    NSLog(@"volumechanged");
}

#pragma mark - TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.runArray.count > 0) {
        return 5;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InfoTableViewCell *cell = (InfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RunCell"];
    
    if (self.runArray.count > 0) {
        Run *runObject = [self.runArray objectAtIndex:indexPath.row];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        cell.date.text = [formatter stringFromDate:runObject.timestamp];
        cell.distance.text = [MathController stringifyDistance:runObject.distance.floatValue];
        cell.pace.text = [MathController stringifyAvgPaceFromDist:runObject.distance.floatValue overTime:runObject.duration.intValue];

    }
    return cell;
}

#pragma mark - Navigation

- (IBAction)unwindToRed:(UIStoryboardSegue *)unwindSegue{}

#pragma mark - MapView Delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1100, 1100);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}

@end
