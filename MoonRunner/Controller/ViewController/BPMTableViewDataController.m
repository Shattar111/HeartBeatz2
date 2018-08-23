//
//  BPMTableViewDataController.m
//  HeartBeatz
//  BPMTableViewDataController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import "BPMTableViewDataController.h"
int BPM1Counter = 0;
int BPM2Counter = 0;
int BPM3Counter = 0;
int BPM4Counter = 0;
int BPM5Counter = 0;
NSString *SongString;
NSString *ArtistString;

@interface BPMTableViewDataController ()

@end

@implementation BPMTableViewDataController
@synthesize items3;
@synthesize ClearButtonEnable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,62,420,700) style:UITableViewStylePlain];
        
        // must set delegate & dataSource, otherwise the the table will be empty and not responsive
        tableView.delegate = self;
        tableView.dataSource = self;
        // [tableView setEditing:YES animated:YES];
        tableView.allowsMultipleSelectionDuringEditing = NO;
        
        //tableView.backgroundColor = [UIColor cyanColor];
        
        // add to canvas
        [self.view addSubview:tableView];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,91,370,700) style:UITableViewStylePlain];
        
        // must set delegate & dataSource, otherwise the the table will be empty and not responsive
        tableView.delegate = self;
        tableView.dataSource = self;
        // [tableView setEditing:YES animated:YES];
        tableView.allowsMultipleSelectionDuringEditing = NO;
        
        //tableView.backgroundColor = [UIColor cyanColor];
        
        // add to canvas
        [self.view addSubview:tableView];
    }
    else
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,62,370,700) style:UITableViewStylePlain];
        
        // must set delegate & dataSource, otherwise the the table will be empty and not responsive
        tableView.delegate = self;
        tableView.dataSource = self;
        // [tableView setEditing:YES animated:YES];
        tableView.allowsMultipleSelectionDuringEditing = NO;
        
        //tableView.backgroundColor = [UIColor cyanColor];
        
        // add to canvas
        [self.view addSubview:tableView];
       // [self PlayButtonEnabled];
    }

    
    //[paintView release];
    
  
  
    self.ClearButtonEnable = NO;
    
    // Do any additional setup after loading the view.
    // self.tableView.backgroundColor = [UIColor cyanColor];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   

    NSString *BPMSelection = [defaults objectForKey:@"BpmSelected"];
    NSLog (@"%@", BPMSelection);

    if ([BPMSelection isEqualToString:@"BPM1"])
    {
        
        NSData *data3 = [defaults objectForKey:@"MusicMediaBPM111"];
        if(data3)
        {
            NSLog(@"BPM1editishit");
            
            MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
            NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM1"];
            
            MPMediaItemCollection *mediaItemCollection2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSArray *items123 = [NSMutableArray arrayWithArray:mediaItemCollection2.items];
            
            NSArray *newArray = [items12 arrayByAddingObjectsFromArray:items123];
            items3 = newArray;
            
            
            MPMediaItemCollection* newCollection = [MPMediaItemCollection collectionWithItems:newArray];
            NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:newCollection];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM111"];
            [defaults setObject:data4 forKey:@"MusicMediaBPM1"];
            [defaults synchronize];
            
            BPM1Counter++;

        }
        else
        {
            NSLog(@"BPM1ishit");

            NSData *data = [defaults objectForKey:@"MusicMediaBPM1"];
        
            MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            items3 = [mediaItemCollection items];
           
            BPM1Counter++;

        }
       
    }
    else if ([BPMSelection isEqualToString:@"BPM2"])
    {
        NSData *data3 = [defaults objectForKey:@"MusicMediaBPM222"];
        if(data3)
        {
            
            
            MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
            NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM2"];
            
            MPMediaItemCollection *mediaItemCollection2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSArray *items123 = [NSMutableArray arrayWithArray:mediaItemCollection2.items];
            
            NSArray *newArray = [items12 arrayByAddingObjectsFromArray:items123];
            items3 = newArray;
            
            
            MPMediaItemCollection* newCollection = [MPMediaItemCollection collectionWithItems:newArray];
            NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:newCollection];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM222"];
            [defaults setObject:data4 forKey:@"MusicMediaBPM2"];
            [defaults synchronize];
          
            BPM2Counter++;

        }
        else
        {
            NSLog(@"BPM2ishit");
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM2"];
            
            MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            items3 = [mediaItemCollection items];
            
            BPM2Counter++;

        }
    }
    else if ([BPMSelection isEqualToString:@"BPM3"])
    {
        NSData *data3 = [defaults objectForKey:@"MusicMediaBPM333"];
        if(data3)
        {
            
            
            MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
            NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM3"];
            
            MPMediaItemCollection *mediaItemCollection2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSArray *items123 = [NSMutableArray arrayWithArray:mediaItemCollection2.items];
            
            NSArray *newArray = [items12 arrayByAddingObjectsFromArray:items123];
            items3 = newArray;
            
            
            MPMediaItemCollection* newCollection = [MPMediaItemCollection collectionWithItems:newArray];
            NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:newCollection];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM333"];
            [defaults setObject:data4 forKey:@"MusicMediaBPM3"];
            [defaults synchronize];
            
            BPM3Counter++;

        }
        else
        {
            NSLog(@"BPM3ishit");
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM3"];
            
            MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            items3 = [mediaItemCollection items];
            
            BPM3Counter++;

        }
    }
    else if ([BPMSelection isEqualToString:@"BPM4"])
    {
        NSData *data3 = [defaults objectForKey:@"MusicMediaBPM444"];
        if(data3)
        {
            
            
            MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
            NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM4"];
            
            MPMediaItemCollection *mediaItemCollection2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSArray *items123 = [NSMutableArray arrayWithArray:mediaItemCollection2.items];
            
            NSArray *newArray = [items12 arrayByAddingObjectsFromArray:items123];
            items3 = newArray;
            
            
            MPMediaItemCollection* newCollection = [MPMediaItemCollection collectionWithItems:newArray];
            NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:newCollection];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM444"];
            [defaults setObject:data4 forKey:@"MusicMediaBPM4"];
            [defaults synchronize];

            BPM4Counter++;

        }
        else
        {
            NSLog(@"BPM4ishit");
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM4"];
            
            MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            items3 = [mediaItemCollection items];
            
            BPM4Counter++;

        }
        
    }
    else if ([BPMSelection isEqualToString:@"BPM5"])
    {
        NSData *data3 = [defaults objectForKey:@"MusicMediaBPM555"];
        if(data3)
        {
            
            
            MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
            NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM5"];
            
            MPMediaItemCollection *mediaItemCollection2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSArray *items123 = [NSMutableArray arrayWithArray:mediaItemCollection2.items];
            
            NSArray *newArray = [items12 arrayByAddingObjectsFromArray:items123];
            items3 = newArray;
            
            
            MPMediaItemCollection* newCollection = [MPMediaItemCollection collectionWithItems:newArray];
            NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:newCollection];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM555"];
            [defaults setObject:data4 forKey:@"MusicMediaBPM5"];
            [defaults synchronize];
            
            BPM5Counter++;

        }
        else
        {
            NSLog(@"BPM5ishit");
            
            NSData *data = [defaults objectForKey:@"MusicMediaBPM5"];
            
            MPMediaItemCollection *mediaItemCollection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            items3 = [mediaItemCollection items];
            
            BPM5Counter++;

        }
    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicEdit"];

    _deletedmusic = NO;

    NSLog(@"viewdidloadtable");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(handleNowPlayingItemChanged:)
                               name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object:controller];

    [notificationCenter addObserver:self
                           selector:@selector(handlePlaybackStateChanged:)
                               name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object:controller];
    [notificationCenter addObserver:self
                           selector:@selector(handleExternalVolumeChanged:)
                               name:MPMusicPlayerControllerVolumeDidChangeNotification
                             object:controller];
   
    [controller beginGeneratingPlaybackNotifications];
   // [[NSNotificationCenter defaultCenter] addObserverForName:nil object:nil queue:nil usingBlock:^(NSNotification *n) { NSLog(@"notification: %@", n); }];

}
- (BOOL)prefersStatusBarHidden {
    
    return NO;
}

-(void)handleNowPlayingItemChanged:(id)notification {
    NSLog(@"nextsongnotification");
   // [MusicPlayerView setHidden:YES];
    //[MusicPlayerView setAlpha:0];
    [MusicPlayerView removeFromSuperview];
    // MPMusicPlayerController *player = (MPMusicPlayerController *)notification;
    
    MPMediaItem *song = [controller nowPlayingItem];
    
    if (song) {
        NSString *title = [song valueForProperty:MPMediaItemPropertyTitle];
        NSString *album = [song valueForProperty:MPMediaItemPropertyAlbumTitle];
        NSString *artist = [song valueForProperty:MPMediaItemPropertyArtist];
        NSString *playCount = [song valueForProperty:MPMediaItemPropertyPlayCount];
        
       // NSLog(@"title: %@", title);
      //  NSLog(@"album: %@", album);
      //  NSLog(@"artist: %@", artist);
       // NSLog(@"playCount: %@", playCount);
        
        MPMediaItemArtwork *artwork = [song valueForProperty: MPMediaItemPropertyArtwork];
        
        if(artwork){
       //    imageView.image = [artwork imageWithSize:imageView.frame.size];
            NSLog(@"hasimagenotification");
            MusicImagine =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
            MusicImagine.image= [artwork imageWithSize:MusicImagine.frame.size];

        }
        else
        {
            NSLog(@"noimagenotification");
            MusicImagine =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
            MusicImagine.image=[UIImage imageNamed:@"Music.png"];

        }
        
        
        
        NSString *platformString = [UIDeviceHardware platformString];
        
        if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
        {
            MusicPlayerView=[[UIView alloc]initWithFrame:CGRectMake(0,670, 580, 90)];
            [MusicPlayerView setBackgroundColor: [UIColor colorWithRed:56/255.0f green:58/255.0f blue:65/255.0f alpha:1.0f]];
            
            blackline=[[UIView alloc]initWithFrame:CGRectMake(0,0, 580, 1)];
            [blackline setBackgroundColor: [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
            
            PlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [PlayButton setBackgroundImage:[UIImage imageNamed:@"Play.png"]
                                  forState:UIControlStateNormal];
            [PlayButton addTarget:self
                           action:@selector(PlayMusic)
                 forControlEvents:UIControlEventTouchUpInside];
            PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            
            PlayButton.userInteractionEnabled = NO;
            PlayButton.enabled = NO;
            PlayButton.hidden = YES;
            PlayButton.frame = CGRectMake(337.0, 20.0, 29.0, 29.0);
            
            PauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [PauseButton setBackgroundImage:[UIImage imageNamed:@"Pause.png"]
                                   forState:UIControlStateNormal];
            [PauseButton addTarget:self
                            action:@selector(PauseMusic)
                  forControlEvents:UIControlEventTouchUpInside];
            PauseButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            PauseButton.frame = CGRectMake(335.0, 18.0, 33.0, 33.0);
            
            FowardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [FowardButton setBackgroundImage:[UIImage imageNamed:@"Forward.png"]
                                    forState:UIControlStateNormal];
            [FowardButton addTarget:self
                             action:@selector(ForwardMusic)
                   forControlEvents:UIControlEventTouchUpInside];
            FowardButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            FowardButton.frame = CGRectMake(370.0, 18.0, 33.0, 33.0);
            
            RewindButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [RewindButton setBackgroundImage:[UIImage imageNamed:@"Rewind.png"]
                                    forState:UIControlStateNormal];
            [RewindButton addTarget:self
                             action:@selector(RewindMusic)
                   forControlEvents:UIControlEventTouchUpInside];
            RewindButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            RewindButton.frame = CGRectMake(300.0, 18.0, 33.0, 33.0);
            
            //   MusicImagine =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
            // MusicImagine.image=[UIImage imageNamed:@"Music.png"];
            
            label=[[UILabel alloc]initWithFrame:CGRectMake(63, 10, 210, 50)];//Set frame of label in your viewcontroller.
            [label setBackgroundColor:[UIColor clearColor]];//Set background color of label.
            [label setText:title];//Set text in label.
            [label setTextColor:[UIColor whiteColor]];//Set text color in label.
            [label setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
            [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
            [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
            //label.font=[label.font fontWithSize:16];
            //[label setNumberOfLines:1];//Set number of lines in label.
            [label setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];

            artistlabel=[[UILabel alloc]initWithFrame:CGRectMake(23, 23, 200, 50)];//Set frame of label in your viewcontroller.
            [artistlabel setBackgroundColor:[UIColor clearColor]];//Set background color of label.
            [artistlabel setText:artist];//Set text in label.
            [artistlabel setTextColor:[UIColor whiteColor]];//Set text color in label.
            [artistlabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
            [artistlabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
            [artistlabel setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
           // artistlabel.font=[artistlabel.font fontWithSize:12];
            //[label setNumberOfLines:1];//Set number of lines in label.
            [artistlabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:12.0]];

            
            [MusicPlayerView addSubview:label];//Add it to the view of your choice.
            [MusicPlayerView addSubview:artistlabel];
            [MusicPlayerView addSubview:MusicImagine];
            [MusicPlayerView addSubview:FowardButton];
            [MusicPlayerView addSubview:PlayButton];
            [MusicPlayerView addSubview:RewindButton];
            [MusicPlayerView addSubview:PauseButton];
            [MusicPlayerView addSubview:blackline];
            [self.view addSubview:MusicPlayerView];
            
        }
        else if ([platformString isEqualToString:@"iPhone X"])
        {
            MusicPlayerView=[[UIView alloc]initWithFrame:CGRectMake(0,721, 375, 90)];
            [MusicPlayerView setBackgroundColor: [UIColor colorWithRed:56/255.0f green:58/255.0f blue:65/255.0f alpha:1.0f]];

            
            blackline=[[UIView alloc]initWithFrame:CGRectMake(0,0, 375, 1)];
            [blackline setBackgroundColor: [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
            
            PlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [PlayButton setBackgroundImage:[UIImage imageNamed:@"Play.png"]
                                  forState:UIControlStateNormal];
            [PlayButton addTarget:self
                           action:@selector(PlayMusic)
                 forControlEvents:UIControlEventTouchUpInside];
            PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            
            PlayButton.userInteractionEnabled = NO;
            PlayButton.enabled = NO;
            PlayButton.hidden = YES;
            PlayButton.frame = CGRectMake(310.0, 20.0, 29.0, 29.0);
            
            PauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [PauseButton setBackgroundImage:[UIImage imageNamed:@"Pause.png"]
                                   forState:UIControlStateNormal];
            [PauseButton addTarget:self
                            action:@selector(PauseMusic)
                  forControlEvents:UIControlEventTouchUpInside];
            PauseButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            PauseButton.frame = CGRectMake(309.0, 18.0, 33.0, 33.0);
            
            FowardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [FowardButton setBackgroundImage:[UIImage imageNamed:@"Forward.png"]
                                    forState:UIControlStateNormal];
            [FowardButton addTarget:self
                             action:@selector(ForwardMusic)
                   forControlEvents:UIControlEventTouchUpInside];
            FowardButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            FowardButton.frame = CGRectMake(338.0, 18.0, 33.0, 33.0);
            
            RewindButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [RewindButton setBackgroundImage:[UIImage imageNamed:@"Rewind.png"]
                                    forState:UIControlStateNormal];
            [RewindButton addTarget:self
                             action:@selector(RewindMusic)
                   forControlEvents:UIControlEventTouchUpInside];
            RewindButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            RewindButton.frame = CGRectMake(278.0, 18.0, 33.0, 33.0);
            
            //   MusicImagine =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
            // MusicImagine.image=[UIImage imageNamed:@"Music.png"];
            
            label=[[UILabel alloc]initWithFrame:CGRectMake(63, 10, 210, 50)];//Set frame of label in your viewcontroller.
            [label setBackgroundColor:[UIColor clearColor]];//Set background color of label.
            [label setText:title];//Set text in label.
            [label setTextColor:[UIColor whiteColor]];//Set text color in label.
            [label setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
            [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
            [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
            //label.font=[label.font fontWithSize:16];
            [label setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];

            //[label setNumberOfLines:1];//Set number of lines in label.
            
            artistlabel=[[UILabel alloc]initWithFrame:CGRectMake(23, 23, 200, 50)];//Set frame of label in your viewcontroller.
            [artistlabel setBackgroundColor:[UIColor clearColor]];//Set background color of label.
            [artistlabel setText:artist];//Set text in label.
            [artistlabel setTextColor:[UIColor whiteColor]];//Set text color in label.
            [artistlabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
            [artistlabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
            [artistlabel setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
            //artistlabel.font=[artistlabel.font fontWithSize:12];
            [artistlabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:12.0]];

            //[label setNumberOfLines:1];//Set number of lines in label.
            
            
            [MusicPlayerView addSubview:label];//Add it to the view of your choice.
            [MusicPlayerView addSubview:artistlabel];
            [MusicPlayerView addSubview:MusicImagine];
            [MusicPlayerView addSubview:FowardButton];
            [MusicPlayerView addSubview:PlayButton];
            [MusicPlayerView addSubview:RewindButton];
            [MusicPlayerView addSubview:PauseButton];
            [MusicPlayerView addSubview:blackline];
            [self.view addSubview:MusicPlayerView];
        }
        else
        {
            MusicPlayerView=[[UIView alloc]initWithFrame:CGRectMake(0,600, 375, 90)];
            [MusicPlayerView setBackgroundColor: [UIColor colorWithRed:56/255.0f green:58/255.0f blue:65/255.0f alpha:1.0f]];
            
            blackline=[[UIView alloc]initWithFrame:CGRectMake(0,0, 375, 1)];
            [blackline setBackgroundColor: [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
            
            PlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [PlayButton setBackgroundImage:[UIImage imageNamed:@"Play.png"]
                                  forState:UIControlStateNormal];
            [PlayButton addTarget:self
                           action:@selector(PlayMusic)
                 forControlEvents:UIControlEventTouchUpInside];
            PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            
            PlayButton.userInteractionEnabled = NO;
            PlayButton.enabled = NO;
            PlayButton.hidden = YES;
            PlayButton.frame = CGRectMake(310.0, 20.0, 29.0, 29.0);
            
            PauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [PauseButton setBackgroundImage:[UIImage imageNamed:@"Pause.png"]
                                   forState:UIControlStateNormal];
            [PauseButton addTarget:self
                            action:@selector(PauseMusic)
                  forControlEvents:UIControlEventTouchUpInside];
            PauseButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            PauseButton.frame = CGRectMake(309.0, 18.0, 33.0, 33.0);
            
            FowardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [FowardButton setBackgroundImage:[UIImage imageNamed:@"Forward.png"]
                                    forState:UIControlStateNormal];
            [FowardButton addTarget:self
                             action:@selector(ForwardMusic)
                   forControlEvents:UIControlEventTouchUpInside];
            FowardButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            FowardButton.frame = CGRectMake(338.0, 18.0, 33.0, 33.0);
            
            RewindButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [RewindButton setBackgroundImage:[UIImage imageNamed:@"Rewind.png"]
                                    forState:UIControlStateNormal];
            [RewindButton addTarget:self
                             action:@selector(RewindMusic)
                   forControlEvents:UIControlEventTouchUpInside];
            RewindButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
            RewindButton.frame = CGRectMake(278.0, 18.0, 33.0, 33.0);
            
            UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
            dot.image=[UIImage imageNamed:@"Music.png"];
            
            label=[[UILabel alloc]initWithFrame:CGRectMake(63, 10, 210, 50)];//Set frame of label in your viewcontroller.
            [label setBackgroundColor:[UIColor clearColor]];//Set background color of label.
            [label setText:SongString];//Set text in label.
            [label setTextColor:[UIColor whiteColor]];//Set text color in label.
            [label setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
            [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
            [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
             [label setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
            //label.font=[label.font fontWithSize:16];
            //[label setNumberOfLines:1];//Set number of lines in label.
            
            artistlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 23, 200, 50)];//Set frame of label in your viewcontroller.
            [artistlabel setBackgroundColor:[UIColor clearColor]];//Set background color of label.
            [artistlabel setText:ArtistString];//Set text in label.
            [artistlabel setTextColor:[UIColor whiteColor]];//Set text color in label.
            [artistlabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
            [artistlabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
            [artistlabel setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
            artistlabel.font=[artistlabel.font fontWithSize:12];
            //[label setNumberOfLines:1];//Set number of lines in label.
            [artistlabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:12.0]];

            
            [MusicPlayerView addSubview:label];//Add it to the view of your choice.
            [MusicPlayerView addSubview:artistlabel];//Add it to the view of your choice.
            [MusicPlayerView addSubview:dot];
            [MusicPlayerView addSubview:FowardButton];
            [MusicPlayerView addSubview:PlayButton];
            [MusicPlayerView addSubview:RewindButton];
            [MusicPlayerView addSubview:PauseButton];
            [MusicPlayerView addSubview:blackline];
            [self.view addSubview:MusicPlayerView];
        }
        

       
    }
}
- (void)handlePlaybackStateChanged:(id)notification {
    NSLog(@"pause and play");
}
- (void)handleExternalVolumeChanged:(id)notification {
    NSLog(@"volumechanged");
}

-(void)ClearButtonDisable
{
    
    
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        Clearbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [Clearbutton addTarget:self
                        action:@selector(ClearButton)
              forControlEvents:UIControlEventTouchUpInside];
        Clearbutton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [Clearbutton setTitle:@"Clear" forState:UIControlStateNormal];
        Clearbutton.userInteractionEnabled = NO;
        
        Clearbutton.enabled = NO;
        Clearbutton.frame = CGRectMake(246.0, 19.0, 100.0, 40.0);
        
        [self.view addSubview:Clearbutton];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        Clearbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [Clearbutton addTarget:self
                        action:@selector(ClearButton)
              forControlEvents:UIControlEventTouchUpInside];
        Clearbutton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [Clearbutton setTitle:@"Clear" forState:UIControlStateNormal];
        Clearbutton.userInteractionEnabled = NO;
        
        Clearbutton.enabled = NO;
        Clearbutton.frame = CGRectMake(216.0, 24.0, 100.0, 40.0);
        
        [self.view addSubview:Clearbutton];
    }
    else
    {
        Clearbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [Clearbutton addTarget:self
                        action:@selector(ClearButton)
              forControlEvents:UIControlEventTouchUpInside];
        Clearbutton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [Clearbutton setTitle:@"Clear" forState:UIControlStateNormal];
        Clearbutton.userInteractionEnabled = NO;
        
        Clearbutton.enabled = NO;
        Clearbutton.frame = CGRectMake(215.0, 18.0, 100.0, 40.0);
        
        [self.view addSubview:Clearbutton];
    }

   

}
-(void)ClearButtonEnabled
{
    
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        Clearbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [Clearbutton addTarget:self
                        action:@selector(ClearButton)
              forControlEvents:UIControlEventTouchUpInside];
        Clearbutton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [Clearbutton setTitle:@"Clear" forState:UIControlStateNormal];
        // Clearbutton.userInteractionEnabled = NO;
          [Clearbutton setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        // Clearbutton.enabled = NO;
        Clearbutton.frame = CGRectMake(246.0, 19.0, 100.0, 40.0);
        
        [self.view addSubview:Clearbutton];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        Clearbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [Clearbutton addTarget:self
                        action:@selector(ClearButton)
              forControlEvents:UIControlEventTouchUpInside];
        Clearbutton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [Clearbutton setTitle:@"Clear" forState:UIControlStateNormal];
        // Clearbutton.userInteractionEnabled = NO;
          [Clearbutton setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        // Clearbutton.enabled = NO;
        Clearbutton.frame = CGRectMake(206.0, 45.0, 100.0, 40.0);
        
        [self.view addSubview:Clearbutton];
    }
    else
    {
        Clearbutton = [UIButton buttonWithType:UIButtonTypeSystem];
        [Clearbutton addTarget:self
                        action:@selector(ClearButton)
              forControlEvents:UIControlEventTouchUpInside];
        Clearbutton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [Clearbutton setTitle:@"Clear" forState:UIControlStateNormal];
        // Clearbutton.userInteractionEnabled = NO;
          [Clearbutton setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        // Clearbutton.enabled = NO;
        Clearbutton.frame = CGRectMake(215.0, 18.0, 100.0, 40.0);
        
        [self.view addSubview:Clearbutton];
    }

  
}
-(void)PlayButtonEnabled
{
    
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        PlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [PlayButton addTarget:self
                       action:@selector(MusicPlayerInApp)
             forControlEvents:UIControlEventTouchUpInside];
        PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [PlayButton setTitle:@"Play" forState:UIControlStateNormal];
        // Clearbutton.userInteractionEnabled = NO;
          [PlayButton setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        // Clearbutton.enabled = NO;
        PlayButton.frame = CGRectMake(70.0, 19.0, 100.0, 40.0);
        
        [self.view addSubview:PlayButton];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        PlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [PlayButton addTarget:self
                       action:@selector(MusicPlayerInApp)
             forControlEvents:UIControlEventTouchUpInside];
        PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [PlayButton setTitle:@"Play" forState:UIControlStateNormal];
        // Clearbutton.userInteractionEnabled = NO;
          [PlayButton setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        // Clearbutton.enabled = NO;
        PlayButton.frame = CGRectMake(70.0, 45.0, 100.0, 40.0);
        
        [self.view addSubview:PlayButton];
    }
    else
    {
        PlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [PlayButton addTarget:self
                       action:@selector(MusicPlayerInApp)
             forControlEvents:UIControlEventTouchUpInside];
        PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [PlayButton setTitle:@"Play" forState:UIControlStateNormal];
        // Clearbutton.userInteractionEnabled = NO;
          [PlayButton setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        // Clearbutton.enabled = NO;
        PlayButton.frame = CGRectMake(70.0, 19.0, 100.0, 40.0);
        
        [self.view addSubview:PlayButton];
    }


}
-(void)PlayButtonDisable
{
    
    
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        PlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [PlayButton addTarget:self
                       action:@selector(MusicPlayerInApp)
             forControlEvents:UIControlEventTouchUpInside];
        PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [PlayButton setTitle:@"Play" forState:UIControlStateNormal];
        PlayButton.userInteractionEnabled = NO;
        
        PlayButton.enabled = NO;
        PlayButton.frame = CGRectMake(70.0, 19.0, 100.0, 40.0);
        
        [self.view addSubview:PlayButton];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        PlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [PlayButton addTarget:self
                       action:@selector(MusicPlayerInApp)
             forControlEvents:UIControlEventTouchUpInside];
        PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [PlayButton setTitle:@"Play" forState:UIControlStateNormal];
        PlayButton.userInteractionEnabled = NO;
        
        PlayButton.enabled = NO;
        PlayButton.frame = CGRectMake(70.0, 24.0, 100.0, 40.0);
        
        [self.view addSubview:PlayButton];
    }
    else
    {
        PlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [PlayButton addTarget:self
                       action:@selector(MusicPlayerInApp)
             forControlEvents:UIControlEventTouchUpInside];
        PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
        [PlayButton setTitle:@"Play" forState:UIControlStateNormal];
        PlayButton.userInteractionEnabled = NO;
        
        PlayButton.enabled = NO;
        PlayButton.frame = CGRectMake(70.0, 19.0, 100.0, 40.0);
        
        [self.view addSubview:PlayButton];
        
    }

 
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    //turn into edit mode
    [tableView setEditing:YES animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)theTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"deleting");
        
        _deletedmusic = YES;
        
        NSMutableArray* array = [NSMutableArray arrayWithCapacity:[items3 count]];
        [array addObjectsFromArray:items3];
        [array removeObjectAtIndex:indexPath.row];
        items3 = [NSArray arrayWithArray:array];
        MPMediaItemCollection* newCollection = [MPMediaItemCollection collectionWithItems:array];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newCollection];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *BPMSelection = [defaults objectForKey:@"BpmSelected"];
        NSLog (@"%@", BPMSelection);
        
        if ([BPMSelection isEqualToString:@"BPM1"])
        {
        
            [defaults setObject:data forKey:@"MusicMediaBPM1"];
            [defaults synchronize];
        }
        else if ([BPMSelection isEqualToString:@"BPM2"])
        {
            [defaults setObject:data forKey:@"MusicMediaBPM2"];
            [defaults synchronize];
        }
        else if ([BPMSelection isEqualToString:@"BPM3"])
        {
            [defaults setObject:data forKey:@"MusicMediaBPM3"];
            [defaults synchronize];
        }
        else if ([BPMSelection isEqualToString:@"BPM4"])
        {
            [defaults setObject:data forKey:@"MusicMediaBPM4"];
            [defaults synchronize];
        }
        else if ([BPMSelection isEqualToString:@"BPM5"])
        {
            [defaults setObject:data forKey:@"MusicMediaBPM5"];
            [defaults synchronize];
        }
       // NSLog (@"Your Array     elements are = %@", items3);
        
        if (controller2.playbackState == MPMusicPlaybackStatePlaying) {
            [controller2 stop];
        }
        if (controller.playbackState == MPMusicPlaybackStatePlaying) {
            [controller stop];
        }
        [tableView reloadData];
        
    }
}
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items3 count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    for( int n=0; n < items3.count; n++ )    {
        MPMediaItem *mediaItem = [items3 objectAtIndex:n];
        NSLog(@"%@songs",[mediaItem valueForProperty:MPMediaItemPropertyTitle]);
    }
    
    
    if(BPM1Counter <= 2)
    {
        [self PlayButtonEnabled];
        [self ClearButtonEnabled];
    }
    else
    {
        [self PlayButtonDisable];
        [self ClearButtonDisable];
    }
    
    if(BPM2Counter <= 2)
    {
        [self PlayButtonEnabled];
        [self ClearButtonEnabled];
    }
    else
    {
        [self PlayButtonDisable];
        [self ClearButtonDisable];
    }
    
    if(BPM3Counter <= 2)
    {
        [self PlayButtonEnabled];
        [self ClearButtonEnabled];
    }
    else
    {
        [self ClearButtonDisable];
        [self PlayButtonDisable];
    }
    
    if(BPM4Counter <= 2)
    {
        [self PlayButtonEnabled];
        [self ClearButtonEnabled];
    }
    else
    {
        [self PlayButtonDisable];
        [self ClearButtonDisable];
    }
    
    if(BPM5Counter <= 2)
    {
        [self PlayButtonEnabled];
        [self ClearButtonEnabled];
    }
    else
    {
        [self PlayButtonDisable];
        [self ClearButtonDisable];
    }
    
    MPMediaItem *item = [items3 objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [item valueForProperty:MPMediaItemPropertyTitle];
    
    SongString = [item valueForProperty:MPMediaItemPropertyTitle];
    
    ArtistString = [item valueForProperty:MPMediaItemPropertyArtist];

    cell.detailTextLabel.text = [item valueForProperty:MPMediaItemPropertyArtist];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    CGSize artworkImageViewSize = CGSizeMake(64, 64);

    MPMediaItemArtwork *art = [item valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *image = [art imageWithSize:artworkImageViewSize];
    if (art)
     {
    cell.imageView.image = image;
     }
    else
    {
    cell.imageView.image = [UIImage imageNamed:@"Music.png"];

    }
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"selected cell textLabel = %@",cell.textLabel.text);
    
   // MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    if (controller.playbackState == MPMusicPlaybackStateStopped) {
    }
        NSArray *songsArray = items3;
    NSUInteger row = indexPath.row;
    
    MPMediaItemCollection *songs = [songsArray objectAtIndex:row];
    
    MPMediaItem *item = [songs representativeItem];
    controller2 = [MPMusicPlayerController applicationMusicPlayer];
    [controller2 setNowPlayingItem:item];
    [controller2 play];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

-(void)MusicPlayerInApp
{
    NSLog(@"playmusic");

    //MPMusicPlayerController* myPlayer = [MPMusicPlayerController systemMusicPlayer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *BPMSelection = [defaults objectForKey:@"BpmSelected"];
    NSLog (@"%@", BPMSelection);
    
    if ([BPMSelection isEqualToString:@"BPM1"])
    {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM1"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        
        [self MusicInfoBar];

    }
    else if ([BPMSelection isEqualToString:@"BPM2"])
    {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM2"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        
        [self MusicInfoBar];

    }
    else if ([BPMSelection isEqualToString:@"BPM3"])
    {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM3"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        
        [self MusicInfoBar];

    }
    else if ([BPMSelection isEqualToString:@"BPM4"])
    {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM4"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        
        [self MusicInfoBar];

    }
    else if ([BPMSelection isEqualToString:@"BPM5"])
    {
        NSData *data = [defaults objectForKey:@"MusicMediaBPM5"];
        MPMediaItemCollection *mediaItemCollection1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSArray *items12 = [NSMutableArray arrayWithArray:mediaItemCollection1.items];
        
        //Plays with ios system..
        controller = [MPMusicPlayerController applicationMusicPlayer];
        //systemMusicPlayer
        //  Plays with in the ios App
        //MPMusicPlayerController *controller = [MPMusicPlayerController applicationMusicPlayer];
        
        
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items12];
        MPMediaItem *item = [collection representativeItem];
        
        [controller setQueueWithItemCollection:collection];
        [controller setNowPlayingItem:item];
        
        // MPMediaItem  *songItem = [controller nowPlayingItem];
        //NSLog (@"%@", songItem);
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter   defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(handleNowPlayingItemChanged:)
                                   name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                 object:controller];
        
        [notificationCenter addObserver:self
                               selector:@selector(handlePlaybackStateChanged:)
                                   name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                 object:controller];
        [notificationCenter addObserver:self
                               selector:@selector(handleExternalVolumeChanged:)
                                   name:MPMusicPlayerControllerVolumeDidChangeNotification
                                 object:controller];
        
        [controller beginGeneratingPlaybackNotifications];
        
        [self PlayMusic];
        
        [self MusicInfoBar];

    }

    
  }
-(void)StopMusic
{
    NSLog(@"StopMusic");
    [controller stop];
    
    PlayButton.userInteractionEnabled = YES;
    PlayButton.enabled = YES;
    PlayButton.hidden = NO;

    PauseButton.userInteractionEnabled = NO;
    PauseButton.enabled = NO;
    PauseButton.hidden = YES;

}
-(void)PauseMusic
{
    NSLog(@"Pausemusic");
    [controller pause];
   
    PlayButton.userInteractionEnabled = YES;
    PlayButton.enabled = YES;
    PlayButton.hidden = NO;
    
    PauseButton.userInteractionEnabled = NO;
    PauseButton.enabled = NO;
    PauseButton.hidden = YES;
    
}
-(void)PlayMusic
{
    NSLog(@"Playmusic");

    [controller prepareToPlay];
    [controller play];
    [controller currentPlaybackTime];
    NSLog (@"%f",  [controller currentPlaybackTime]);

    PauseButton.userInteractionEnabled = YES;
    PauseButton.enabled = YES;
    PauseButton.hidden = NO;

    PlayButton.userInteractionEnabled = NO;
    PlayButton.enabled = NO;
    PlayButton.hidden = YES;

}
-(void)RewindMusic
{
    NSLog(@"rewindmusic");
    [controller skipToPreviousItem];

}
-(void)ForwardMusic
{
    NSLog(@"forwardmusic");
    [controller skipToNextItem];

}
-(void)MusicInfoBar
{
    NSString *platformString = [UIDeviceHardware platformString];
    
    if ([platformString isEqualToString:@"iPhone 7 Plus"] || [platformString isEqualToString:@"iPhone 8 Plus"] || [platformString isEqualToString:@"iPhone 6 Plus"] || [platformString isEqualToString:@"iPhone 6s Plus"])
    {
        [self MusicBariPhoneplus];
    }
    else if ([platformString isEqualToString:@"iPhone X"])
    {
        [self MusicBariPhoneX];
    }
    else
    {
        [self MusicBariPhoneSmall];
    }
}

-(void)MusicBariPhoneSmall
{
    MusicPlayerView=[[UIView alloc]initWithFrame:CGRectMake(0,600, 375, 90)];
    [MusicPlayerView setBackgroundColor: [UIColor colorWithRed:208/255.0f green:212/255.0f blue:229/255.0f alpha:1.0f]];
    
    blackline=[[UIView alloc]initWithFrame:CGRectMake(0,0, 375, 1)];
    [blackline setBackgroundColor: [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
    
    PlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [PlayButton setBackgroundImage:[UIImage imageNamed:@"Play.png"]
                          forState:UIControlStateNormal];
    [PlayButton addTarget:self
                   action:@selector(PlayMusic)
         forControlEvents:UIControlEventTouchUpInside];
    PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    
    PlayButton.userInteractionEnabled = NO;
    PlayButton.enabled = NO;
    PlayButton.hidden = YES;
    PlayButton.frame = CGRectMake(310.0, 20.0, 29.0, 29.0);
    
    PauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [PauseButton setBackgroundImage:[UIImage imageNamed:@"Pause.png"]
                           forState:UIControlStateNormal];
    [PauseButton addTarget:self
                    action:@selector(PauseMusic)
          forControlEvents:UIControlEventTouchUpInside];
    PauseButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    PauseButton.frame = CGRectMake(309.0, 18.0, 33.0, 33.0);
    
    FowardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [FowardButton setBackgroundImage:[UIImage imageNamed:@"Forward.png"]
                            forState:UIControlStateNormal];
    [FowardButton addTarget:self
                     action:@selector(ForwardMusic)
           forControlEvents:UIControlEventTouchUpInside];
    FowardButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    FowardButton.frame = CGRectMake(338.0, 18.0, 33.0, 33.0);
    
    RewindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [RewindButton setBackgroundImage:[UIImage imageNamed:@"Rewind.png"]
                            forState:UIControlStateNormal];
    [RewindButton addTarget:self
                     action:@selector(RewindMusic)
           forControlEvents:UIControlEventTouchUpInside];
    RewindButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    RewindButton.frame = CGRectMake(278.0, 18.0, 33.0, 33.0);
    
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
    dot.image=[UIImage imageNamed:@"Music.png"];
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(63, 10, 210, 50)];//Set frame of label in your viewcontroller.
    [label setBackgroundColor:[UIColor clearColor]];//Set background color of label.
    [label setText:SongString];//Set text in label.
    [label setTextColor:[UIColor whiteColor]];//Set text color in label.
    [label setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
    [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
    label.font=[label.font fontWithSize:16];
    //[label setNumberOfLines:1];//Set number of lines in label.
    
    artistlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 23, 200, 50)];//Set frame of label in your viewcontroller.
    [artistlabel setBackgroundColor:[UIColor clearColor]];//Set background color of label.
    [artistlabel setText:ArtistString];//Set text in label.
    [artistlabel setTextColor:[UIColor whiteColor]];//Set text color in label.
    [artistlabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [artistlabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
    [artistlabel setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
    artistlabel.font=[artistlabel.font fontWithSize:12];
    //[label setNumberOfLines:1];//Set number of lines in label.
    
    
    [MusicPlayerView addSubview:label];//Add it to the view of your choice.
    [MusicPlayerView addSubview:artistlabel];//Add it to the view of your choice.
    [MusicPlayerView addSubview:dot];
    [MusicPlayerView addSubview:FowardButton];
    [MusicPlayerView addSubview:PlayButton];
    [MusicPlayerView addSubview:RewindButton];
    [MusicPlayerView addSubview:PauseButton];
    [MusicPlayerView addSubview:blackline];
    [self.view addSubview:MusicPlayerView];
    
}

-(void)MusicBariPhoneX
{
    MusicPlayerView=[[UIView alloc]initWithFrame:CGRectMake(0,721, 375, 90)];
    [MusicPlayerView setBackgroundColor: [UIColor colorWithRed:56/255.0f green:58/255.0f blue:65/255.0f alpha:1.0f]];
    
    blackline=[[UIView alloc]initWithFrame:CGRectMake(0,0, 375, 1)];
    [blackline setBackgroundColor: [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
    
    PlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [PlayButton setBackgroundImage:[UIImage imageNamed:@"Play.png"]
                          forState:UIControlStateNormal];
    [PlayButton addTarget:self
                   action:@selector(PlayMusic)
         forControlEvents:UIControlEventTouchUpInside];
    PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    
    PlayButton.userInteractionEnabled = NO;
    PlayButton.enabled = NO;
    PlayButton.hidden = YES;
    PlayButton.frame = CGRectMake(310.0, 20.0, 29.0, 29.0);
    
    PauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [PauseButton setBackgroundImage:[UIImage imageNamed:@"Pause.png"]
                           forState:UIControlStateNormal];
    [PauseButton addTarget:self
                    action:@selector(PauseMusic)
          forControlEvents:UIControlEventTouchUpInside];
    PauseButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    PauseButton.frame = CGRectMake(309.0, 18.0, 33.0, 33.0);
    
    FowardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [FowardButton setBackgroundImage:[UIImage imageNamed:@"Forward.png"]
                            forState:UIControlStateNormal];
    [FowardButton addTarget:self
                     action:@selector(ForwardMusic)
           forControlEvents:UIControlEventTouchUpInside];
    FowardButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    FowardButton.frame = CGRectMake(338.0, 18.0, 33.0, 33.0);
    
    RewindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [RewindButton setBackgroundImage:[UIImage imageNamed:@"Rewind.png"]
                            forState:UIControlStateNormal];
    [RewindButton addTarget:self
                     action:@selector(RewindMusic)
           forControlEvents:UIControlEventTouchUpInside];
    RewindButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    RewindButton.frame = CGRectMake(278.0, 18.0, 33.0, 33.0);
    
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
    dot.image=[UIImage imageNamed:@"Music.png"];
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(63, 10, 210, 50)];//Set frame of label in your viewcontroller.
    [label setBackgroundColor:[UIColor clearColor]];//Set background color of label.
    [label setText:SongString];//Set text in label.
    [label setTextColor:[UIColor whiteColor]];//Set text color in label.
    [label setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
    [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
    label.font=[label.font fontWithSize:16];
    //[label setNumberOfLines:1];//Set number of lines in label.
    
    artistlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 23, 200, 50)];//Set frame of label in your viewcontroller.
    [artistlabel setBackgroundColor:[UIColor clearColor]];//Set background color of label.
    [artistlabel setText:ArtistString];//Set text in label.
    [artistlabel setTextColor:[UIColor whiteColor]];//Set text color in label.
    [artistlabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [artistlabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
    [artistlabel setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
    artistlabel.font=[artistlabel.font fontWithSize:12];
    //[label setNumberOfLines:1];//Set number of lines in label.
    
    
    [MusicPlayerView addSubview:label];//Add it to the view of your choice.
    [MusicPlayerView addSubview:artistlabel];//Add it to the view of your choice.
    [MusicPlayerView addSubview:dot];
    [MusicPlayerView addSubview:FowardButton];
    [MusicPlayerView addSubview:PlayButton];
    [MusicPlayerView addSubview:RewindButton];
    [MusicPlayerView addSubview:PauseButton];
    //[MusicPlayerView addSubview:blackline];
    [self.view addSubview:MusicPlayerView];
    
    
}
-(void)MusicBariPhoneplus
{
    MusicPlayerView=[[UIView alloc]initWithFrame:CGRectMake(0,670, 580, 90)];
    [MusicPlayerView setBackgroundColor: [UIColor colorWithRed:208/255.0f green:212/255.0f blue:229/255.0f alpha:1.0f]];
    
    blackline=[[UIView alloc]initWithFrame:CGRectMake(0,0, 580, 1)];
    [blackline setBackgroundColor: [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]];
    
    PlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [PlayButton setBackgroundImage:[UIImage imageNamed:@"Play.png"]
                          forState:UIControlStateNormal];
    [PlayButton addTarget:self
                   action:@selector(PlayMusic)
         forControlEvents:UIControlEventTouchUpInside];
    PlayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    
    PlayButton.userInteractionEnabled = NO;
    PlayButton.enabled = NO;
    PlayButton.hidden = YES;
    PlayButton.frame = CGRectMake(337.0, 20.0, 29.0, 29.0);
    
    PauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [PauseButton setBackgroundImage:[UIImage imageNamed:@"Pause.png"]
                           forState:UIControlStateNormal];
    [PauseButton addTarget:self
                    action:@selector(PauseMusic)
          forControlEvents:UIControlEventTouchUpInside];
    PauseButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    PauseButton.frame = CGRectMake(335.0, 18.0, 33.0, 33.0);
    
    FowardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [FowardButton setBackgroundImage:[UIImage imageNamed:@"Forward.png"]
                            forState:UIControlStateNormal];
    [FowardButton addTarget:self
                     action:@selector(ForwardMusic)
           forControlEvents:UIControlEventTouchUpInside];
    FowardButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    FowardButton.frame = CGRectMake(370.0, 18.0, 33.0, 33.0);
    
    RewindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [RewindButton setBackgroundImage:[UIImage imageNamed:@"Rewind.png"]
                            forState:UIControlStateNormal];
    [RewindButton addTarget:self
                     action:@selector(RewindMusic)
           forControlEvents:UIControlEventTouchUpInside];
    RewindButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    RewindButton.frame = CGRectMake(300.0, 18.0, 33.0, 33.0);
    
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(10,8,50,50)];
    dot.image=[UIImage imageNamed:@"Music.png"];
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(63, 10, 210, 50)];//Set frame of label in your viewcontroller.
    [label setBackgroundColor:[UIColor clearColor]];//Set background color of label.
    [label setText:SongString];//Set text in label.
    [label setTextColor:[UIColor whiteColor]];//Set text color in label.
    [label setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
    [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
    label.font=[label.font fontWithSize:16];
    //[label setNumberOfLines:1];//Set number of lines in label.
    
    artistlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 23, 200, 50)];//Set frame of label in your viewcontroller.
    [artistlabel setBackgroundColor:[UIColor clearColor]];//Set background color of label.
    [artistlabel setText:ArtistString];//Set text in label.
    [artistlabel setTextColor:[UIColor whiteColor]];//Set text color in label.
    [artistlabel setTextAlignment:NSTextAlignmentCenter];//Set text alignment in label.
    [artistlabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
    [artistlabel setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
    artistlabel.font=[artistlabel.font fontWithSize:12];
    //[label setNumberOfLines:1];//Set number of lines in label.
    
    
    [MusicPlayerView addSubview:label];//Add it to the view of your choice.
    [MusicPlayerView addSubview:artistlabel];//Add it to the view of your choice.
    [MusicPlayerView addSubview:dot];
    [MusicPlayerView addSubview:FowardButton];
    [MusicPlayerView addSubview:PlayButton];
    [MusicPlayerView addSubview:RewindButton];
    [MusicPlayerView addSubview:PauseButton];
    [MusicPlayerView addSubview:blackline];
    [self.view addSubview:MusicPlayerView];
    
}
-(IBAction)ClearButton{
   
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"HeartBeatz" message:@"Clear all media from BPM"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        [self okButtonPressed];
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        
                                        
                                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                        
                                        NSString *BPMSelection = [defaults objectForKey:@"BpmSelected"];
                                        NSLog (@"%@", BPMSelection);
                                        
                                        if ([BPMSelection isEqualToString:@"BPM1"])
                                        {
                                            NSLog(@"dleteddd");
                                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM1"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            BPM1Counter = 0;
                                        }
                                        else if ([BPMSelection isEqualToString:@"BPM2"])
                                        {
                                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM2"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            BPM2Counter = 0;

                                        }
                                        else if ([BPMSelection isEqualToString:@"BPM3"])
                                        {
                                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM3"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            BPM3Counter = 0;

                                        }
                                        else if ([BPMSelection isEqualToString:@"BPM4"])
                                        {
                                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM4"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            BPM4Counter = 0;

                                        }
                                        else if ([BPMSelection isEqualToString:@"BPM5"])
                                        {
                                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MusicMediaBPM5"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            BPM5Counter = 0;

                                        }

                                        
                                        
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [self cancelButtonPressed];

                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];

}
- (void)cancelButtonPressed
{
    NSLog(@"cancel pressd");

    // write your implementation for cancel button here.
}

- (void)okButtonPressed
{
    NSLog(@"ok pressd");
    //write your implementation for ok button here
    [self dismissViewControllerAnimated:YES completion:nil];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BpmSelected"];
    self.ClearButtonEnable = NO;

}

-(IBAction)DissmissBPMView:(id)sender{
    
    [MusicPlayerView removeFromSuperview];
    [MusicPlayerView2 removeFromSuperview];
    [controller stop];
    [controller2 stop]; 
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BpmSelected"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *BPMSelection = [defaults objectForKey:@"BpmSelected"];
    NSLog (@"%@", BPMSelection);
    
    if ([BPMSelection isEqualToString:@"BPM1"])
    {
        BPM1Counter = 0;
        
    }
    else if ([BPMSelection isEqualToString:@"BPM2"])
    {
        BPM2Counter = 0;
        
    }
    else if ([BPMSelection isEqualToString:@"BPM3"])
    {
        BPM3Counter = 0;
        
    }
    else if ([BPMSelection isEqualToString:@"BPM4"])
    {
        BPM4Counter = 0;
        
    }
    else if ([BPMSelection isEqualToString:@"BPM5"])
    {
        BPM5Counter = 0;
        
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
