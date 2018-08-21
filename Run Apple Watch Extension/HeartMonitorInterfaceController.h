//
//  HeartMonitorInterfaceController.h
//  HeartBeatz
//  HeartMonitorInterfaceController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//
#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import "Math.h"
#import "InterfaceController.h"

@interface HeartMonitorInterfaceController : WKInterfaceController <HKWorkoutSessionDelegate> {
    
    HKHealthStore *healthStore;
    HKWorkoutSession *workoutSession;
    HKAnchoredObjectQuery *heartQuery;
    HKAnchoredObjectQuery *distanceQuery;
    NSPredicate *Predicate;
    
    NSTimer *timer;
    NSTimer *timeTimer;
    BOOL isClear;
}
@property int Seconds;
@property int Miliseconds;
@property NSMutableArray *heartBeatArray;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *currentLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *LowestLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *secondLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *milisecondLabel;

@end
