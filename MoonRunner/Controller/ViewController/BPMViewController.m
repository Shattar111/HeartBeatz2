//
//  BPMViewController.m
//  HeartBeatz
//  BPMViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import "BPMViewController.h"

@interface BPMViewController ()

@end

@implementation BPMViewController
@synthesize items3;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

    //makes all buttons in tabcontroller disabled?... but hides tab bar icon.
   // NSMutableArray *newTabs = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
   // [newTabs removeObjectAtIndex: 0];
    
    //[self.tabBarController setViewControllers:newTabs];
}
#pragma mark - UITableViewDataSource
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BPM1ButtonPushed:(id)sender{
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    // Configure the media query to group its media items; here, grouped by artist
    [everything setGroupingType: MPMediaGroupingArtist];
    
    // Obtain the media item collections from the query
   // NSArray *collections = [everything collections];
  //  NSLog (@"Your Array elements are bpmview = %@", collections);
  //  NSLog(@"hit");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *MusicEdit = [defaults objectForKey:@"MusicEdit"];
    NSLog (@"%@", MusicEdit);
    
    if ([MusicEdit isEqualToString:@"mediaedit"])
    {
        NSLog(@"musicedit");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *BPM1 = @"BPM1";
    
    NSData *data = [defaults objectForKey:@"MusicMedia"];
    MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
       
    NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
    
    [defaults setObject:BPM1 forKey:@"BpmSelected"];
    
    NSData *data2 = [defaults objectForKey:@"MusicMediaBPM1"];
    if(data2)
    {
        NSData *data22 = [defaults objectForKey:@"MusicMedia"];
        
        [defaults setObject:data22 forKey:@"MusicMediaBPM111"];
        [defaults synchronize];
    }
    else
    {
        [defaults setObject:datanew forKey:@"MusicMediaBPM1"];
        [defaults synchronize];
    }
        
    }
    else
    {
        NSString *BPM1 = @"BPM1";

        NSData *data = [defaults objectForKey:@"MusicMediaBPM1"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        [defaults setObject:BPM1 forKey:@"BpmSelected"];
        [defaults setObject:datanew forKey:@"MusicMediaBPM1"];
        [defaults synchronize];
    }

    [self BPMTableView];
    
}

-(IBAction)BPM2ButtonPushed:(id)sender{
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    // Configure the media query to group its media items; here, grouped by artist
    [everything setGroupingType: MPMediaGroupingArtist];
    
    // Obtain the media item collections from the query
    // NSArray *collections = [everything collections];
    //  NSLog (@"Your Array elements are bpmview = %@", collections);
    //  NSLog(@"hit");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *MusicEdit = [defaults objectForKey:@"MusicEdit"];
    NSLog (@"%@", MusicEdit);
    
    if ([MusicEdit isEqualToString:@"mediaedit"])
    {
        NSLog(@"musicedit");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *BPM2 = @"BPM2";
        
        NSData *data = [defaults objectForKey:@"MusicMedia"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        
        [defaults setObject:BPM2 forKey:@"BpmSelected"];
        
        NSData *data2 = [defaults objectForKey:@"MusicMediaBPM2"];
        if(data2)
        {
            NSData *data22 = [defaults objectForKey:@"MusicMedia"];
            
            [defaults setObject:data22 forKey:@"MusicMediaBPM222"];
            [defaults synchronize];
        }
        else
        {
            [defaults setObject:datanew forKey:@"MusicMediaBPM2"];
            [defaults synchronize];
        }
    }
    else
    {
        NSLog(@"musin not edited");
        //looks like we have to read user default music medisbpm1 then rewrtie music bpm1 to a userdefault.
        NSString *BPM2 = @"BPM2";
        
        NSData *data = [defaults objectForKey:@"MusicMediaBPM2"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        [defaults setObject:BPM2 forKey:@"BpmSelected"];
        [defaults setObject:datanew forKey:@"MusicMediaBPM2"];
        [defaults synchronize];
    }
    
    [self BPMTableView];
}

-(IBAction)BPM3ButtonPushed:(id)sender{
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    // Configure the media query to group its media items; here, grouped by artist
    [everything setGroupingType: MPMediaGroupingArtist];
    
    // Obtain the media item collections from the query
    // NSArray *collections = [everything collections];
    //  NSLog (@"Your Array elements are bpmview = %@", collections);
    //  NSLog(@"hit");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *MusicEdit = [defaults objectForKey:@"MusicEdit"];
    NSLog (@"%@", MusicEdit);
    
    if ([MusicEdit isEqualToString:@"mediaedit"])
    {
        NSLog(@"musicedit");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *BPM3 = @"BPM3";
        
        NSData *data = [defaults objectForKey:@"MusicMedia"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        
        [defaults setObject:BPM3 forKey:@"BpmSelected"];
        
        NSData *data2 = [defaults objectForKey:@"MusicMediaBPM3"];
        if(data2)
        {
            NSData *data22 = [defaults objectForKey:@"MusicMedia"];
            
            [defaults setObject:data22 forKey:@"MusicMediaBPM333"];
            [defaults synchronize];
        }
        else
        {
            [defaults setObject:datanew forKey:@"MusicMediaBPM3"];
            [defaults synchronize];
        }

    }
    else
    {
        NSLog(@"musin not edited");
        //looks like we have to read user default music medisbpm1 then rewrtie music bpm1 to a userdefault.
        NSString *BPM3 = @"BPM3";
        
        NSData *data = [defaults objectForKey:@"MusicMediaBPM3"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        [defaults setObject:BPM3 forKey:@"BpmSelected"];
        [defaults setObject:datanew forKey:@"MusicMediaBPM3"];
        [defaults synchronize];
    }
    
    [self BPMTableView];

}
-(IBAction)BPM4ButtonPushed:(id)sender{
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    // Configure the media query to group its media items; here, grouped by artist
    [everything setGroupingType: MPMediaGroupingArtist];
    
    // Obtain the media item collections from the query
    // NSArray *collections = [everything collections];
    //  NSLog (@"Your Array elements are bpmview = %@", collections);
    //  NSLog(@"hit");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *MusicEdit = [defaults objectForKey:@"MusicEdit"];
    NSLog (@"%@", MusicEdit);
    
    if ([MusicEdit isEqualToString:@"mediaedit"])
    {
        NSLog(@"musicedit");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *BPM4 = @"BPM4";
        
        NSData *data = [defaults objectForKey:@"MusicMedia"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        
        [defaults setObject:BPM4 forKey:@"BpmSelected"];
        
        NSData *data2 = [defaults objectForKey:@"MusicMediaBPM4"];
        if(data2)
        {
            NSData *data22 = [defaults objectForKey:@"MusicMedia"];
            
            [defaults setObject:data22 forKey:@"MusicMediaBPM444"];
            [defaults synchronize];
        }
        else
        {
            [defaults setObject:datanew forKey:@"MusicMediaBPM4"];
            [defaults synchronize];
        }
    }
    else
    {
        NSLog(@"musin not edited");
        //looks like we have to read user default music medisbpm1 then rewrtie music bpm1 to a userdefault.
        NSString *BPM4 = @"BPM4";
        
        NSData *data = [defaults objectForKey:@"MusicMediaBPM4"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        [defaults setObject:BPM4 forKey:@"BpmSelected"];
        [defaults setObject:datanew forKey:@"MusicMediaBPM4"];
        [defaults synchronize];
    }
    
    [self BPMTableView];

}
-(IBAction)BPM5ButtonPushed:(id)sender{
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    // Configure the media query to group its media items; here, grouped by artist
    [everything setGroupingType: MPMediaGroupingArtist];
    
    // Obtain the media item collections from the query
    // NSArray *collections = [everything collections];
    //  NSLog (@"Your Array elements are bpmview = %@", collections);
    //  NSLog(@"hit");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *MusicEdit = [defaults objectForKey:@"MusicEdit"];
    NSLog (@"%@", MusicEdit);
    
    if ([MusicEdit isEqualToString:@"mediaedit"])
    {
        NSLog(@"musicedit");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *BPM5 = @"BPM5";
        
        NSData *data = [defaults objectForKey:@"MusicMedia"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        
        [defaults setObject:BPM5 forKey:@"BpmSelected"];
       
        NSData *data2 = [defaults objectForKey:@"MusicMediaBPM5"];
        if(data2)
        {
            NSData *data22 = [defaults objectForKey:@"MusicMedia"];
            
            [defaults setObject:data22 forKey:@"MusicMediaBPM555"];
            [defaults synchronize];
        }
        else
        {
            [defaults setObject:datanew forKey:@"MusicMediaBPM5"];
            [defaults synchronize];
        }
    }
    else
    {
        NSLog(@"musin not edited");
        //looks like we have to read user default music medisbpm1 then rewrtie music bpm1 to a userdefault.
        NSString *BPM5 = @"BPM5";
        
        NSData *data = [defaults objectForKey:@"MusicMediaBPM5"];
        MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:mediaItemCollection];
        [defaults setObject:BPM5 forKey:@"BpmSelected"];
        [defaults setObject:datanew forKey:@"MusicMediaBPM5"];
        [defaults synchronize];
    }
    
    [self BPMTableView];

    
}

-(IBAction)DissmissBPMView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    
    return NO;
}
-(void)BPMTableView
{
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMTableView" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMTableView"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMTableViewIphoneX" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMTableViewIphoneX"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"BPMTableViewiphone7" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"BPMTableViewiphone7"];
        
        viewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:viewController animated:YES completion:nil];
    }
   
    
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
