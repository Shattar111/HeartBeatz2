//
//  InterfaceController.m
//  HeartBeatz
//  InterfaceController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end

@implementation InterfaceController

#pragma mark - Query HealthKit

-(void)updateDistance{
    
    __weak typeof(self) weakSelf = self;
    
    HKSampleType *object = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    distanceQuery = [[HKAnchoredObjectQuery alloc] initWithType:object predicate:Predicate anchor:0 limit:0 resultsHandler:^(HKAnchoredObjectQuery *query, NSArray<HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error) {
        
        if (!error && sampleObjects) {
            HKQuantitySample *sample = (HKQuantitySample *)[sampleObjects lastObject];
            self.distance = self.distance + [sample.quantity doubleValueForUnit:[HKUnit unitFromString:@"m"]];
            [self.milageLabel setText:[Math stringifyDistance:weakSelf.distance]];
            [self.paceLabel setText:[Math stringifyAvgPaceFromDist:self.distance overTime:self.seconds]];
        }else{
            NSLog(@"error %@", error);
        }
        
    }];
    [distanceQuery setUpdateHandler:^(HKAnchoredObjectQuery *query, NSArray<HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error) {
        
        if (!error && sampleObjects) {
            HKQuantitySample *sample = (HKQuantitySample *)[sampleObjects lastObject];
            weakSelf.distance = self.distance + [sample.quantity doubleValueForUnit:[HKUnit unitFromString:@"m"]];
            [weakSelf.milageLabel setText:[Math stringifyDistance:weakSelf.distance]];
            [weakSelf.paceLabel setText:[Math stringifyAvgPaceFromDist:weakSelf.distance overTime:weakSelf.seconds]];
        }else{
            NSLog(@"error %@", error);
        }
    }];
    
    [healthStore executeQuery:distanceQuery];
}

-(void)updateHeartbeat{
    
    __weak typeof(self) weakSelf = self;
    
    HKSampleType *object = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    
    heartQuery = [[HKAnchoredObjectQuery alloc] initWithType:object predicate:Predicate anchor:0 limit:0 resultsHandler:^(HKAnchoredObjectQuery *query, NSArray<HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error) {
        
        if (!error && sampleObjects.count > 0) {
            HKQuantitySample *sample = (HKQuantitySample *)[sampleObjects lastObject];
            HKQuantity *quantity = sample.quantity;
            [self.heartBeatArray addObject:[NSString stringWithFormat:@"%f", [quantity doubleValueForUnit:[HKUnit unitFromString:@"count/min"]]]];
            [self.heartLabel setText:[NSString stringWithFormat:@"%@BPM", [self.heartBeatArray lastObject]]];
           // NSLog(@"heartbeat %@", [self.heartBeatArray lastObject]);

        }else{
            NSLog(@"query %@", error);
        }
        
    }];
    [heartQuery setUpdateHandler:^(HKAnchoredObjectQuery *query, NSArray<HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error){
        
        if (!error && sampleObjects.count > 0) {
            HKQuantitySample *sample = (HKQuantitySample *)[sampleObjects lastObject];
            HKQuantity *quantity = sample.quantity;
            [weakSelf.heartBeatArray addObject:[NSString stringWithFormat:@"%.0f", [quantity doubleValueForUnit:[HKUnit unitFromString:@"count/min"]]]];
            [weakSelf.heartLabel setText:[NSString stringWithFormat:@"%@BPM", [weakSelf.heartBeatArray lastObject]]];
            NSLog(@"heartbeat2 %@",[weakSelf.heartBeatArray lastObject]);
           
            __weak typeof(self) weakSelf = self;

            NSString *HB = [weakSelf.heartBeatArray lastObject];
           
             //delay for heartbeat is every 10 seconds, no point to have data check every seconds
           // double delayInSeconds = 10.0;
           // dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
           // dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
           //     [weakSelf showLog:HB];
           // });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [weakSelf showLog:HB];
            });
            
            
            
            /*
             read heartbeat later
             
             NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //saving username in the memory if the connection is successfull
             
             NSString* hbsaved = [prefs objectForKey:@"hbsaved"];
             */

        }else{
            NSLog(@"query %@", error);
        }
    }];
    
    [healthStore executeQuery:heartQuery];
}
- (void)showLog:(NSString*)data{
   
    
    NSLog(@"%@Heartbeat2", data);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *hbsaved = data;
    
    [prefs setObject:hbsaved forKey:@"hbsaved"];
    [prefs synchronize];
    
    
    NSString *counterString = data;
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"counterValue"]];
    NSLog( @"dctionaryvalue%@", applicationData);
  //  [self.session updateApplicationContext:applicationData error:nil];

    NSString *counterString2 = hbsaved;
    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[counterString2] forKeys:@[@"counterValue2"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];

}

- (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDate *startDate = [calendar startOfDayForDate:now];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}
- (void)fetchSumOfSamplesTodayForType:(HKQuantityType *)quantityType unit:(HKUnit *)unit completion:(void (^)(double, NSError *))completionHandler {
    NSPredicate *predicate = [self predicateForSamplesToday];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        HKQuantity *sum = [result sumQuantity];
        NSString *string=[NSString stringWithFormat:@"%@",sum];
        NSString *string2=[NSString stringWithFormat:@"%@",result];

        NSLog(@"RESULT  : =>  %@",string);
        NSLog(@"RESULT2  : =>  %@",string2);

        if (completionHandler) {
            double value = [sum doubleValueForUnit:unit];
            
            completionHandler(value, error);
        }
    }];
    
    [healthStore executeQuery:query];
}

-(void)calorieupdate
{
    
    HKHealthStore* healthStore = [[HKHealthStore alloc] init];
    
    NSDate* timeOfWorkout = [NSDate date];
    
    
}

-(void)updateSteps
{
    HKQuantityType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];


//[healthStore ];
//NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];

// NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:YES];
NSSortDescriptor *timeSortDescription = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
            query = [[HKSampleQuery alloc] initWithSampleType:type
                     predicate:nil
                         limit:HKObjectQueryNoLimit
               sortDescriptors:@[timeSortDescription]
                resultsHandler:^(HKSampleQuery *query, NSArray *result, NSError *error){
                    
                    //NSLog(@"RESULT  : =>  %@",result);
                    if(!error && result)
                    { long totalSteps=0;
                        for(HKQuantitySample *quantitySample in result)
                        {
                            // your code here
                            HKQuantity  *quantity=quantitySample.quantity;
                            //HKQuantity *quantity = quantitySample.quantity;
                            NSString *string=[NSString stringWithFormat:@"%@",quantity];
                            NSString *newString1 = [string stringByReplacingOccurrencesOfString:@" count" withString:@""];
                           NSLog(@"RESULT  : =>  %@",string);
                            NSLog(@"RESULT  : =>  %@",newString1);

                            NSInteger count=[newString1 integerValue];
                            totalSteps=totalSteps+count;
                           // NSLog(@"RESULT  : =>  %i",count);

                        }
                        //using total steps
                    }
                }];
[healthStore executeQuery:query];
    
    
    
    
    /*  another way of gettig steps
     NSCalendar *calendar = [NSCalendar currentCalendar];
     NSDateComponents *interval = [[NSDateComponents alloc] init];
     interval.day = 1;
     
     NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
     fromDate:[NSDate date]];
     anchorComponents.hour = 0;
     NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
     HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
     
     // Create the query
     HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
     quantitySamplePredicate:nil
     options:HKStatisticsOptionCumulativeSum
     anchorDate:anchorDate
     intervalComponents:interval];
     
     // Set the results handler
     query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
     if (error) {
     // Perform proper error handling here
     NSLog(@"*** An error occurred while calculating the statistics: %@ ***",error.localizedDescription);
     }
     
     NSDate *endDate = [NSDate date];
     NSDate *startDate = [calendar dateByAddingUnit:NSCalendarUnitDay
     value:-7
     toDate:endDate
     options:0];
     
     // Plot the daily step counts over the past 7 days
     [results enumerateStatisticsFromDate:startDate
     toDate:endDate
     withBlock:^(HKStatistics *result, BOOL *stop) {
     
     HKQuantity *quantity = result.sumQuantity;
     if (quantity) {
     NSDate *date = result.startDate;
     double value = [quantity doubleValueForUnit:[HKUnit countUnit]];
     NSLog(@"%@: %f", date, value);
     }
     
     }];
     };
     
     [healthStore executeQuery:query];
     */
}
- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
    NSString *counterValue = [message objectForKey:@"ArtistNameWatch"];
    NSString *StopWorkout = [message objectForKey:@"StopPhoneToWatchWorkout"];
    NSString *StartWorkout = [message objectForKey:@"StartPhoneToWatchWorkout"];
    NSString *PauseWorkout = [message objectForKey:@"PausePhoneToWatchWorkout"];

    NSString *LapLabelValue = [message objectForKey:@"LapLabelValuetoWatch"];

    //  if (!self.counterData) {
    // self.counterData = [[NSMutableArray alloc] init];
    // }

    //Use this to update the UI instantaneously (otherwise, takes a little while)
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //[self.counterData addObject:counterValue];
        // [self.mainTableView reloadData];
        
        //NSString *test = @"teststring";
        [self.MusicLabel setText:counterValue];
        //label heere for watch see if i can send data from differnt controller to watch.
        [self StopTimerFromPhone:StopWorkout];
        [self StartTimerFromPhone:StartWorkout];
        [self PauseTimerFromPhone:PauseWorkout];
        [self LapIncreasedFromPhone:LapLabelValue];

    });
}

- (void)LapIncreasedFromPhone:(NSString*)LapWorkout
{
 // change watch lap label here...
    NSArray *listItems = [LapWorkout componentsSeparatedByString:@","];
    
    NSString *val = [listItems objectAtIndex: 1];
    
    [self.LapLabel setText:[NSString stringWithFormat:@"LAP%@", val]];
    
    //set watch label to val, lap val
    NSLog(@"data----%@",val);
    
}

- (void)PauseTimerFromPhone:(NSString*)PauseWorkout
{
    if([PauseWorkout containsString:@"PAU"])
    {
        [self PauseFromPhone];
    }
}



- (void)StopTimerFromPhone:(NSString*)StopWorkout{
    
    if([StopWorkout containsString:@"ST"])
    {
        [self StopFromPhone];
    }

}
- (void)StartTimerFromPhone:(NSString*)StartWorkout{
    
    if([StartWorkout containsString:@"ART"])
    {
        [self StartFromPhone];
    }
    
}
-(void)StartFromPhone
{
    [self.StartHeartWorkout setHidden:YES];
    [self.StartWorkoutLabel setHidden:YES];
    
    if (started == NO) {
        
        self.heartBeatArray = [[NSMutableArray alloc] init];
        self.splitsArray = [[NSMutableArray alloc] init];
        self.distance = 0.00;
        self.seconds = 0;
        
        [self.timeLabel setHidden:YES];
        [self.paceLabel setHidden:YES];
        [self.milageLabel setHidden:YES];
        [self.heartLabel setHidden:YES];
        [self.LapLabel setHidden:YES];

        [self.image setImageNamed:@"single"];
        
        CountDown = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }

}
-(void)StopFromPhone
{
    [Pedometer stopPedometerUpdates];
    [Timer invalidate];
    Timer = nil;
    [healthStore endWorkoutSession:workoutSession];
    [healthStore stopQuery:heartQuery];
    [healthStore stopQuery:distanceQuery];
    
    self.data = @{@"time": [NSString stringWithFormat:@"%i", self.seconds],
                  @"distance": [NSString stringWithFormat:@"%f", self.distance],
                  @"splits": self.splitsArray,
                  @"heart": self.heartBeatArray,
                  @"mili": [NSString stringWithFormat:@"%i", self.miliseconds]};
    
    NSLog(@"data %@", self.data);
    
    started = NO;
    
    [self pushControllerWithName:@"detail" context:self.data];
}
-(void)PauseFromPhone
{
    [Pedometer stopPedometerUpdates];
    [Timer invalidate];
    [healthStore pauseWorkoutSession:workoutSession];
    // [healthStore stopQuery:heartQuery];
    //[healthStore stopQuery:distanceQuery];
    
    
    [self.PauseHeartWorkout setHidden:YES];
    [self.ResumeHeartWorkout setHidden:NO];
    [self.image setHidden:YES];
    [self.timeLabel setHidden:NO];
    [self.paceLabel setHidden:YES];
    [self.milageLabel setHidden:YES];
    [self.heartLabel setHidden:NO];
    [self.LapLabel setHidden:NO];

    [self.milisecondsLabel setHidden:NO];
    [self.StopHeartWorkout setHidden:NO];
    


}
#pragma mark - HealthKit Delegate
-(void)workoutSession:(HKWorkoutSession *)workoutSession didFailWithError:(NSError *)error{
    
    NSLog(@"session error %@", error);
}


-(void)workoutSession:(HKWorkoutSession *)workoutSession didChangeToState:(HKWorkoutSessionState)toState fromState:(HKWorkoutSessionState)fromState date:(NSDate *)date{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (toState) {
            case HKWorkoutSessionStateRunning:
                [self updateHeartbeat];
                [self updateDistance];
                [self startPedometer];
                [self updateSteps];
                [self calorieupdate];
                started = YES;
                NSLog(@"workout started");
                break;
            case HKWorkoutSessionStateEnded:
                NSLog(@"ended");
                break;
            case HKWorkoutSessionStateNotStarted:
                NSLog(@"not started");
                break;

            default:
                break;
        }
    });
}

#pragma mark - Private Methods

- (IBAction)splitPressed:(id)sender{

    NSDictionary *dict = @{@"distance": [Math stringifyDistance:self.distance],
                           @"time": [Math stringifySecondCount:self.seconds usingLongFormat:NO],
                           @"heart": self.heartBeatArray,
                           @"mili": [NSString stringWithFormat:@"%i", self.miliseconds]};
    [self.heartBeatArray removeAllObjects];
    [self.splitsArray addObject:dict];
    self.distance = 0;
    self.seconds = 0;
    [self.timeLabel setText:@"00:00"];
}


-(IBAction)Resume:(id)sender{
    //executeQuery
    //startWorkoutSession
   
    [self startPedometer];
    
    //[Timer fire];
    Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
    
    [healthStore resumeWorkoutSession:workoutSession];
  //  [healthStore executeQuery:heartQuery];
   // [healthStore executeQuery:distanceQuery];
    
    [self.PauseHeartWorkout setHidden:NO];
    [self.ResumeHeartWorkout setHidden:YES];
    [self.image setHidden:YES];
    [self.timeLabel setHidden:NO];
    [self.paceLabel setHidden:NO];
    [self.milageLabel setHidden:NO];
    [self.heartLabel setHidden:NO];
    [self.LapLabel setHidden:NO];
    [self.milisecondsLabel setHidden:NO];
    [self.StopHeartWorkout setHidden:NO];

    NSString *counterString2 = @"YES";
    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[counterString2] forKeys:@[@"StartTimerWatch"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];

}

-(IBAction)Pause:(id)sender{
    //pauseWorkoutSession
    //stopQuery
    
    [Pedometer stopPedometerUpdates];
    [Timer invalidate];
    [healthStore pauseWorkoutSession:workoutSession];
   // [healthStore stopQuery:heartQuery];
    //[healthStore stopQuery:distanceQuery];
    
    
    [self.PauseHeartWorkout setHidden:YES];
    [self.ResumeHeartWorkout setHidden:NO];
    [self.image setHidden:YES];
    [self.timeLabel setHidden:NO];
    [self.paceLabel setHidden:YES];
    [self.milageLabel setHidden:YES];
    [self.heartLabel setHidden:NO];
    [self.LapLabel setHidden:NO];

    [self.milisecondsLabel setHidden:NO];
    [self.StopHeartWorkout setHidden:NO];

    
    NSString *counterString2 = @"DONE";
    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[counterString2] forKeys:@[@"PauseTimerPhone"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];

    
}

-(IBAction)stop:(id)sender{

    [Pedometer stopPedometerUpdates];
    [Timer invalidate];
    Timer = nil;
    [healthStore endWorkoutSession:workoutSession];
    [healthStore stopQuery:heartQuery];
    [healthStore stopQuery:distanceQuery];
    
    self.data = @{@"time": [NSString stringWithFormat:@"%i", self.seconds],
             @"distance": [NSString stringWithFormat:@"%f", self.distance],
             @"splits": self.splitsArray,
             @"heart": self.heartBeatArray,
             @"mili": [NSString stringWithFormat:@"%i", self.miliseconds]};

    NSLog(@"data %@", self.data);
    
    started = NO;
    
    NSString *counterString2 = @"STOP";
    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[counterString2] forKeys:@[@"StopTimerPhone"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];

    
    [self pushControllerWithName:@"detail" context:self.data];
}

-(IBAction)discard{
    
    [Timer invalidate];
    [Pedometer stopPedometerUpdates];
    [healthStore endWorkoutSession:workoutSession];
    [healthStore stopQuery:heartQuery];
    
    [self pushControllerWithName:@"home" context:nil];
}

-(void)startPedometer{
    
    Pedometer = [[CMPedometer alloc] init];
    [Pedometer startPedometerUpdatesFromDate:[NSDate dateWithTimeIntervalSinceNow:0] withHandler:^(CMPedometerData *pedometerData, NSError *error) {
        if (!error) {
            NSLog(@"steps %@", [Math stringifyStrideRateFromSteps:pedometerData.numberOfSteps.intValue overTime:self.seconds]);
        }else{
            NSLog(@"%@", error);
        }
    }];
}

-(void)timerCount{
    
    self.miliseconds+=10;
    [self.milisecondsLabel setText:[NSString stringWithFormat:@"%i", self.miliseconds]];
    if (self.miliseconds == 100) {
        self.miliseconds = 0;
        self.seconds++;
        [self.timeLabel setText:[Math stringifySecondCount:self.seconds usingLongFormat:NO]];
    }
}
// tomrrow make a counterdown method 2, connect method to the wkbuttonn idRUN, add timers delegates by sending string to watch to phone then phone to watch to turn off on timer.. also add start button to iphone main screeen to start coountdown2 method. then watch can stop /start workout to..


//add start stop button on iphone main screen, default start , workout hides start shows stop,, stop workout hides stop shows run and those button are connected to the timer on iphone screen and watch...

- (IBAction)Countdown2:(id)sender{
    
    [self.StartHeartWorkout setHidden:YES];
    [self.StartWorkoutLabel setHidden:YES];

    NSString *counterString2 = @"YES";
    NSDictionary *applicationData2 = [[NSDictionary alloc] initWithObjects:@[counterString2] forKeys:@[@"StartTimerWatch"]];
    
    [[WCSession defaultSession] sendMessage:applicationData2
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];

    if (started == NO) {
        
        self.heartBeatArray = [[NSMutableArray alloc] init];
        self.splitsArray = [[NSMutableArray alloc] init];
        self.distance = 0.00;
        self.seconds = 0;
        
        [self.timeLabel setHidden:YES];
        [self.paceLabel setHidden:YES];
        [self.milageLabel setHidden:YES];
        [self.heartLabel setHidden:YES];
        [self.LapLabel setHidden:YES];

        [self.image setImageNamed:@"single"];
        
        CountDown = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }

}




-(void)countDown{
    
    static int count = 1;
    static int start = 1;
    CountDown = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    [self.image startAnimatingWithImagesInRange:NSMakeRange(start, count * 30) duration:0.3 repeatCount:1];
    [self.image startAnimatingWithImagesInRange:NSMakeRange(count * 30, count * 30 + 4) duration:0.5 repeatCount:1];
        count ++;
        start = start + 34;
        if (count == 4) {
            [CountDown invalidate];
    
            [self.image setHidden:YES];
            [self.timeLabel setHidden:NO];
            [self.paceLabel setHidden:NO];
            [self.milageLabel setHidden:NO];
            [self.heartLabel setHidden:NO];
            [self.LapLabel setHidden:NO];

            [self.StopHeartWorkout setHidden:NO];
            [self.milisecondsLabel setHidden:NO];
            [self.PauseHeartWorkout setHidden:NO];
            [self.ResumeHeartWorkout setHidden:NO];
            
            Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
            
            Predicate = [HKQuery predicateForSamplesWithStartDate:[NSDate dateWithTimeIntervalSinceNow:0] endDate:nil options:HKQueryOptionNone];
            healthStore = [[HKHealthStore alloc] init];
         
            workoutSession = [[HKWorkoutSession alloc] initWithActivityType:HKWorkoutActivityTypeRunning locationType:HKWorkoutSessionLocationTypeIndoor];
            workoutSession.delegate = self;
          
            HKWorkoutConfiguration * wkConfig = [[HKWorkoutConfiguration alloc]init];
            wkConfig.activityType = HKWorkoutActivityTypeRunning;
            wkConfig.locationType = HKWorkoutSessionLocationTypeIndoor;
          
            NSError *error = nil;
            workoutSession = [[HKWorkoutSession alloc] initWithConfiguration:wkConfig error:&error];
            workoutSession.delegate = self;
            [healthStore startWorkoutSession:workoutSession];
           // [healthStore startWorkoutSession:workoutSession];
        }
    }];
}

#pragma mark - Life Cycle

- (void)willActivate {
    
    
    if ([WCSession isSupported]) {
        self.session = [WCSession defaultSession];
        self.session.delegate = self;
        [self.session activateSession];
    }
   
    if (started == NO) {
        
        self.heartBeatArray = [[NSMutableArray alloc] init];
        self.splitsArray = [[NSMutableArray alloc] init];
        self.distance = 0.00;
        self.seconds = 0;
        
        [self.StopHeartWorkout setHidden:YES];
        [self.timeLabel setHidden:YES];
        [self.paceLabel setHidden:YES];
        [self.milageLabel setHidden:YES];
        [self.heartLabel setHidden:YES];
        [self.LapLabel setHidden:YES];

        [self.image setImageNamed:@"single"];
        [self.PauseHeartWorkout setHidden:YES];
        [self.ResumeHeartWorkout setHidden:YES];
        [self.milisecondsLabel setHidden:YES];
        
    }


    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    
    [super didDeactivate];
}
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

@end
