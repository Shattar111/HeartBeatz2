//
//  ButtonTableCell.m
//  HeartBeatz
//  ButtonTableCell
//
//  Created by Shattar Sihra on 2017-05-23.
//  Copyright © 2016 Shattar Sihra. All rights reserved.
//

#import "ButtonTableCell.h"

@implementation ButtonTableCell

-(IBAction)great:(id)sender{
    
    if (_delegate != nil) {
        [_delegate feedbackWithButton:self.greatButton];
    }
}

-(IBAction)ok:(id)sender{
    
    if (_delegate != nil) {
        [_delegate feedbackWithButton:self.okButton];
    }
    
}
-(IBAction)terrible:(id)sender{
    
    if (_delegate != nil) {
        [_delegate feedbackWithButton:self.terribleButton];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
