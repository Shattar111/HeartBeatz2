//
//  LeftViewController.m
//  LGSideMenuControllerDemo
//
//  Created by Grigory Lutkov on 18.02.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "LeftViewCell.h"
#import "MainViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LeftViewController ()

@property (nonatomic, assign) CGPoint circleTransitionStartPoint;
@property (nonatomic, assign) CGRect transitionCellRect;
@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) NSArray *imageArray;

@end

@implementation LeftViewController
@synthesize musicPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // -----
    _titlesArray = @[@"HeartBeatz",
                     @"",
                     @"Home",
                     @"Media",
                     @"BPM Playlist",
                     @"Preference",];
    _imageArray = @[@"", @"", @"Housesettings", @"Musicsettings",@"bpmsettings", @"settingsleft"];

    // -----
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(44.f, 0.f, 44.f, 0.f);
    self.tableView.alwaysBounceVertical = NO;


    musicPlayer = [MPMusicPlayerController applicationMusicPlayer];






}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titlesArray.count;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.label.text = _titlesArray[indexPath.row];
    cell.image.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    cell.separatorView.hidden = !(indexPath.row != 0 && indexPath.row != 1 && indexPath.row != _titlesArray.count-1);
    cell.userInteractionEnabled = (indexPath.row != 1);
    cell.label.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) return 22.f;
    else return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [kMainViewController hideLeftViewAnimated:YES completionHandler:nil];
    UINavigationController *today = [self.storyboard instantiateViewControllerWithIdentifier:@"idRunHome"];
    UINavigationController *projects = [self.storyboard instantiateViewControllerWithIdentifier:@"idRunHistory"];
    UINavigationController *calendar = [self.storyboard instantiateViewControllerWithIdentifier:@"idRunHome"];
    UINavigationController *preference = [self.storyboard instantiateViewControllerWithIdentifier:@"idRunPreference"];
    
    MainViewController *mainViewController = [self.storyboard instantiateInitialViewController];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    switch (indexPath.row) {
        case 2:
            mainViewController.rootViewController = today;
            window.rootViewController = mainViewController;
            [UIView transitionWithView:window
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:nil];
            break;
        case 3:
            
            [self MusicSelector];
         
            break;
        case 4:
            [self BpmPlayListView];
            break;
        case 5:
            mainViewController.rootViewController = preference;
            window.rootViewController = mainViewController;
            [UIView transitionWithView:window
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:nil];
            break;
            
        default:
            break;
    }
    [mainViewController setupWithPresentationStyle:LGSideMenuPresentationStyleSlideBelow type:0];
}
-(void)BpmPlayListView
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



-(void)MusicSelector
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





@end
