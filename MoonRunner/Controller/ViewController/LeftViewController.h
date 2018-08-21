//
//  LeftViewController.h
//  LGSideMenuControllerDemo
//
//  Created by Grigory Lutkov on 18.02.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CLMediaPicker.h"
#import "BPMViewController.h"
#import "NDIntroView.h"
#import "JDFTooltips.h"
#import "UIDeviceHardware.h"
@interface LeftViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate,MPMediaPlayback,MPPlayableContentDelegate,MPMediaPickerControllerDelegate,MPPlayableContentDataSource,CLMediaPickerDelegate,NDIntroViewDelegate>
{
    
}

@property (strong, nonatomic) UIColor *tintColor;
@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;
@property (strong, nonatomic) NDIntroView *introView;
@property (nonatomic, strong) JDFSequentialTooltipManager *tooltipManager;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *BPMButton;
@property (weak, nonatomic) IBOutlet UIButton *lastPageButton;
@property (weak, nonatomic) IBOutlet UIButton *MediaButton;
@property (weak, nonatomic) IBOutlet UILabel *Label23;


@end
