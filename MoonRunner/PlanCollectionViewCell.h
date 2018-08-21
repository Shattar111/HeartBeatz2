//
//  PlanCollectionViewCell.h
//  HeartBeatz
//  PlanCollectionViewCell
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSDate *date;

@property (weak, nonatomic) IBOutlet UIImageView *weather;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
