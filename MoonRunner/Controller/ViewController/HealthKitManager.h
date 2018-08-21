//
//  HealthKitManager.h
//  HeartBeatz
//  HealthKitManager
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface HealthKitManager : NSObject

+ (HealthKitManager *)sharedManager;

- (void)requestAuthorization;

- (NSDate *)readBirthDate;

@end
