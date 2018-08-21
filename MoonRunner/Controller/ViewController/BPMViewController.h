//
//  BPMViewController.h
//  HeartBeatz
//  BPMViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CLMediaPicker.h"
#import "BPMTableViewDataController.h"
#import "UIDeviceHardware.h"

@interface BPMViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,MPMediaPlayback,MPPlayableContentDelegate,MPMediaPickerControllerDelegate,MPPlayableContentDataSource,CLMediaPickerDelegate,UITableViewDelegate,UITabBarDelegate>
{
     // UITableView *tableView;
    NSArray *items3;
}
@property (weak, nonatomic) IBOutlet UIButton *Done;

@property (weak, nonatomic) IBOutlet UIButton *BPM1;
@property (weak, nonatomic) IBOutlet UIButton *BPM2;
@property (weak, nonatomic) IBOutlet UIButton *BPM3;
@property (weak, nonatomic) IBOutlet UIButton *BPM4;
@property (weak, nonatomic) IBOutlet UIButton *BPM5;
@property (weak, nonatomic) IBOutlet UIButton *BPM6;

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UITableView *tableview;
//@property (nonatomic,strong) NSArray *arr;
//@property (nonatomic,strong) NSArray *items3;
@property(nonatomic,retain) NSArray* items3;
@property (nonatomic) BOOL deletedmusic;

@end

