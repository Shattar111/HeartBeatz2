//
//  InterfaceController.h
//  HeartBeatz
//  InterfaceController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Math.h"
#import "DetailInterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>

BOOL started;

@interface InterfaceController : WKInterfaceController <HKWorkoutSessionDelegate,WCSessionDelegate> {
    
    HKHealthStore *healthStore;
    HKWorkoutSession *workoutSession;
    HKAnchoredObjectQuery *heartQuery;
    HKAnchoredObjectQuery *distanceQuery;
    NSPredicate *Predicate;
    
    CMPedometer *Pedometer;
    HKSampleQuery    *query;
    NSTimer *CountDown;
    NSTimer *Timer;
}
@property int seconds;
@property int miliseconds;
@property float distance;
@property (strong, nonatomic) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *heartBeatArray;
@property (nonatomic, strong) NSMutableArray *splitsArray;
@property (strong, nonatomic) WCSession *session;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *paceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *milageLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *heartLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *MusicLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *LapLabel;

@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *timeLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *milisecondsLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *StartHeartWorkout;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *StartWorkoutLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *StopHeartWorkout;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *PauseHeartWorkout;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *ResumeHeartWorkout;
@end
// Stopwatch Components
