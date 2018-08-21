//
//  SummaryTableViewCell.h
//  HeartBeatz
//  SummaryTableViewCell
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *time;
@property (nonatomic, weak) IBOutlet UILabel *pace;
@property (nonatomic, weak) IBOutlet UILabel *calories;

@end
