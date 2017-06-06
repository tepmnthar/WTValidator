//
//  ExampleTableViewCell.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "ExampleTableViewCell.h"

@implementation ExampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lbIndicator.text = @"😐";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateIndicator:(WTValidatorStatus)status {
    switch (status) {
        case WTValidatorStatusUncheck:
            self.lbIndicator.text = @"😐";
            break;
        case WTValidatorStatusFail:
            self.lbIndicator.text = @"☹️";
            break;
        case WTValidatorStatusPass:
            self.lbIndicator.text = @"😆";
            break;
    }
}

@end
