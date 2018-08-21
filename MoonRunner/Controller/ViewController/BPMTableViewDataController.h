//
//  BPMTableViewDataController.h
//  HeartBeatz
//  BPMTableViewDataController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "CLMediaPicker.h"
//#import "BPMTableViewDataController.h"
#import "UIDeviceHardware.h"

#import <UIKit/UIKit.h>

@interface BPMTableViewDataController : UIViewController<UITableViewDelegate, UITableViewDataSource,MPMediaPlayback,MPPlayableContentDelegate,MPMediaPickerControllerDelegate,MPPlayableContentDataSource,CLMediaPickerDelegate,UITableViewDelegate>
{
    NSArray *items3;
    UIButton *Clearbutton;
    UIButton *PlayButton;
    UIButton *PauseButton;
    UIButton *FowardButton;
    UIButton *RewindButton;
    MPMusicPlayerController *controller;
    MPMusicPlayerController *controller2;
    UIView *MusicPlayerView;
    UIView *MusicPlayerView2;
    UIImageView *MusicImagine;
    UIView *blackline;
    UILabel *label;
    UILabel *artistlabel;

}
@property(nonatomic,retain) NSArray* items3;
@property (nonatomic) BOOL deletedmusic;
@property (nonatomic,assign) BOOL ClearButtonEnable;

@end
