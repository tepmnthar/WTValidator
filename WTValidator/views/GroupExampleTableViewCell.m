//
//  GroupExampleTableViewCell.m
//  WTValidator
//
//  Created by tepmnthar on 08/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "GroupExampleTableViewCell.h"

@implementation GroupExampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.sliderIndicator.text = @"😐";
    self.textViewIndicator.text = @"😐";
    self.textFieldIndicator.text = @"😐";
    
    self.slider.wt_validatorHandler = ^(WTValidatorStatus status) {
        [self updateIndicator:self.sliderIndicator status:status];
    };
    self.textField.wt_validatorHandler = ^(WTValidatorStatus status) {
        [self updateIndicator:self.textFieldIndicator status:status];
    };
    self.textView.wt_validatorHandler = ^(WTValidatorStatus status) {
        [self updateIndicator:self.textViewIndicator status:status];
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textView.text = @"";
    self.textField.text = @"";
}
- (void)updateIndicator:(UILabel*)indicator status:(WTValidatorStatus)status {
    switch (status) {
        case WTValidatorStatusUncheck:
            indicator.text = @"😐";
            break;
        case WTValidatorStatusFail:
            indicator.text = @"☹️";
            break;
        case WTValidatorStatusPass:
            indicator.text = @"😆";
            break;
    }
}

@end
