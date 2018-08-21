//
//  HomeInterfaceController.m
//  HeartBeatz
//  HomeInterfaceController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import "HomeInterfaceController.h"
#import "InterfaceController.h"
#import <Healthkit/HealthKit.h>

@interface HomeInterfaceController ()

@end

@implementation HomeInterfaceController

- (void)awakeWithContext:(id)context {

    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    HKQuantityType *type2 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType *type3 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantityType *type4 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

    [healthStore requestAuthorizationToShareTypes:nil readTypes:[NSSet setWithObjects:type, type2, type3,type4, nil] completion:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"requested");
        if (success) {
           
            NSLog(@"health data request success");
            
        }else{
            NSLog(@"error %@", error);
        }
    }];
    started = NO;

    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end
