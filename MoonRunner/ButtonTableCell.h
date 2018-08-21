//
//  ButtonTableCell
//  HeartBeatz
//  ButtonTableCell
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonTableCell : UITableViewCell

@property (assign, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UIButton *greatButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *terribleButton;

@end

@protocol buttonTableCellDelegate <NSObject>

-(void)feedbackWithButton:(UIButton *)button;

@end
