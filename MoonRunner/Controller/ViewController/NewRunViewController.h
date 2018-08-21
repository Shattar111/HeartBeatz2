//
//  NewRunViewController.h
//  HeartBeatz
//  NewRunViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MapKit/MapKit.h>
#import <CoreMotion/CoreMotion.h>
#import <WatchConnectivity/WatchConnectivity.h>

#import "MathController.h"
#import "Run.h"
#import "Location.h"
#import "RunDetailsViewController.h"
#import "SettingViewController.h"
#import "YQL.h"

@interface NewRunViewController : UIViewController <UIActionSheetDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, WCSessionDelegate>{
    
    int temperate;
    
    NSTimer *timer;
    NSTimer *startTimer;
    NSTimer *timeTimer;
    
    CMPedometer *Pedometer;
    CMAltimeter *altimeter;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property int seconds;
@property float distance;
@property int miliseconds;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSMutableArray *splitsArray;
@property (nonatomic, strong) NSMutableArray *strides;
@property (nonatomic, strong) NSMutableArray *altitude;
@property (nonatomic, strong) NSMutableArray *heartRate;
@property (nonatomic, strong) Run *run;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MapWidth;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *distLabel;
@property (nonatomic, weak) IBOutlet UILabel *paceLabel;
@property (nonatomic, weak) IBOutlet UILabel *calories;
@property (nonatomic, weak) IBOutlet UILabel *countDownLabel;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *milisecLabel;
@property (nonatomic, weak) IBOutlet UIButton *split;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) IBOutlet UIImageView *cover;

@end
