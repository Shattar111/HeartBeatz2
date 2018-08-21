//
//  ProgressViewController.h
//  HeartBeatz
//  ProgressViewController
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PNChart.h"
#import "UIColor+GraphKit.h"
#import "PlanCollectionViewCell.h"
#import "TrophyCollectionViewCell.h"

@interface ProgressViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, PNChartDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *planCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *trophyCollectionView;

@property (weak, nonatomic) NSArray *barData;
@property (weak, nonatomic) NSMutableArray *labels;

@end
