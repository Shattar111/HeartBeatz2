//
//  HomeViewController.h
//  HeartBeatz
//  HomeViewControlle
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import "NewRunViewController.h"
#import "PastRunViewController.h"
#import "InfoTableViewCell.h"
#import "HealthKitManager.h"
#import "MathController.h"
#import "SettingViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CLMediaPicker.h"
#import "BPMViewController.h"
#import "NDIntroView.h"
#import "JDFTooltips.h"
#import <CoreMotion/CoreMotion.h>

@import CoreMotion;

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, WCSessionDelegate,MPMediaPlayback,MPPlayableContentDelegate,MPMediaPickerControllerDelegate,MPPlayableContentDataSource,CLMediaPickerDelegate,NDIntroViewDelegate>{
    NSTimer *timer;
    JDFTooltipView *tooltip;
    BOOL _Removetipview;
    MPMusicPlayerController *controller;
    CMPedometer *pedometer;
    // NSTimer *timermethod;
    NSDate *startDate;

}
@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;
@property (nonatomic, strong) Run *run;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NDIntroView *introView;
@property (nonatomic, strong) JDFSequentialTooltipManager *tooltipManager;


@property (weak, nonatomic) IBOutlet UILabel *MusicBeingPlayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *MusicPlayed;

@property (weak, nonatomic) IBOutlet UILabel *LapLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalDistance;
@property (weak, nonatomic) IBOutlet UILabel *longestRun;
@property (weak, nonatomic) IBOutlet UILabel *LastLap;
@property (weak, nonatomic) IBOutlet UILabel *totalRuns;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MapWidth;
@property (weak, nonatomic) IBOutlet UIButton *BPMButton;
@property (weak, nonatomic) IBOutlet UIButton *lastPageButton;
@property (weak, nonatomic) IBOutlet UIButton *MediaButton;

@property (weak, nonatomic) IBOutlet UILabel *Label23;
@property (weak, nonatomic) IBOutlet UILabel *Labelheart;
@property (nonatomic) WCSession* Session;

@property (weak, nonatomic) IBOutlet UILabel *stopwatchTimeLabel;
@property (weak, nonatomic) NSTimer *myTimer;
@property int currentTimeInSeconds;

@property (weak, nonatomic) IBOutlet UIButton *StartButton;
@property (weak, nonatomic) IBOutlet UIButton *StopButton;
@property (weak, nonatomic) IBOutlet UIButton *PauseButton;
@property (weak, nonatomic) IBOutlet UIButton *LapButton;
@property (weak, nonatomic) IBOutlet UIButton *AddedMedialibrary;
@property (weak, nonatomic) IBOutlet UIButton *IphoneMusicLibrary;

@property (weak, nonatomic) NSTimer *timermethod;

@end
