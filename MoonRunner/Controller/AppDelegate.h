//
//  AppDelegate.h
//  HeartBeatz
//  AppDelegate
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import "Run.h"
#import "MainViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIDeviceHardware.h"

#define kMainViewController (MainViewController *)[UIApplication sharedApplication].delegate.window.rootViewController

@import FirebaseAnalytics;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WCSessionDelegate,MPMediaPlayback,MPPlayableContentDelegate,MPMediaPickerControllerDelegate,MPPlayableContentDataSource>{
    HKHealthStore *healthStore;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Run *run;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
