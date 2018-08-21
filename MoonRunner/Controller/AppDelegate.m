//
//  AppDelegate.m
//  HeartBeatz
//  AppDelegate
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        [FIRApp configure];
    if([UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    }
    NSString *platform = [UIDeviceHardware platform];
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    //  NSLog (@"%@", platform);
    // NSLog (@"%@", platformString);
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"idRunHome"];
        MainViewController *mainViewController = [storyboard instantiateInitialViewController];
        mainViewController.managedObjectContext = self.managedObjectContext;
        mainViewController.rootViewController = navigationController;
        self.window.rootViewController = mainViewController;
        [UIView transitionWithView:self.window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
        [mainViewController setupWithPresentationStyle:LGSideMenuPresentationStyleSlideBelow type:0];
        
        /* for background modde audio playback fix?
         NSError *setCategoryErr = nil;
         NSError *activationErr  = nil;
         [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&setCategoryErr];
         [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
         */
        
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        
        NSLog(@"iphoneX");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainiphoneX" bundle:[NSBundle mainBundle]];
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"idRunHome"];
        MainViewController *mainViewController = [storyboard instantiateInitialViewController];
        mainViewController.managedObjectContext = self.managedObjectContext;
        mainViewController.rootViewController = navigationController;
        self.window.rootViewController = mainViewController;
        [UIView transitionWithView:self.window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
        [mainViewController setupWithPresentationStyle:LGSideMenuPresentationStyleSlideBelow type:0];
        
        /* for background modde audio playback fix?
         NSError *setCategoryErr = nil;
         NSError *activationErr  = nil;
         [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&setCategoryErr];
         [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
         */
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mainiphonesmall" bundle:[NSBundle mainBundle]];
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"idRunHome"];
        MainViewController *mainViewController = [storyboard instantiateInitialViewController];
        mainViewController.managedObjectContext = self.managedObjectContext;
        mainViewController.rootViewController = navigationController;
        self.window.rootViewController = mainViewController;
        [UIView transitionWithView:self.window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
        [mainViewController setupWithPresentationStyle:LGSideMenuPresentationStyleSlideBelow type:0];
        
        /* for background modde audio playback fix?
         NSError *setCategoryErr = nil;
         NSError *activationErr  = nil;
         [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&setCategoryErr];
         [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
         */
    }

    return YES;
}

-(void)applicationShouldRequestHealthAuthorization:(UIApplication *)application{
    
    [healthStore handleAuthorizationForExtensionWithCompletion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"phone recieved health kit request");
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    WCSession *session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BpmSelected"];

}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RunMaster" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"RunMaster.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - WCsession delegates

-(void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *,id> *)userInfo{
    
    NSLog(@"recieved message %@", userInfo);
    
    Run *newRun = [NSEntityDescription insertNewObjectForEntityForName:@"Run" inManagedObjectContext:self.managedObjectContext];
    
    newRun.distance = [NSNumber numberWithFloat:[[userInfo objectForKey:@"distance"] floatValue]];
    newRun.duration = [NSNumber numberWithInt:[[userInfo objectForKey:@"time"] intValue]];
    newRun.timestamp = [NSDate date];
    newRun.splits = [NSKeyedArchiver archivedDataWithRootObject:[userInfo objectForKey:@"splits"]];
    newRun.heart_rate = [NSKeyedArchiver archivedDataWithRootObject:[userInfo objectForKey:@"heart"]];
    newRun.miliseconds = [NSNumber numberWithInt:[[userInfo objectForKey:@"mili"] intValue]];
    
    self.run = newRun;
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(void)sessionWatchStateDidChange:(WCSession *)session{
    NSLog(@"watch status changed");
}
-(void)sessionDidDeactivate:(WCSession *)session{
    NSLog(@"session deactivated");
}
- (void)sessionDidBecomeInactive:(WCSession *)session{
    NSLog(@"session inactive");

}
- (void)sessionReachabilityDidChange:(WCSession *)session{
    NSLog(@"reachability chanage");

}


@end