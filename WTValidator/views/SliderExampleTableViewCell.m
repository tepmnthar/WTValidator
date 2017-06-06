//
//  SliderExampleTableViewCell.m
//  WTValidator
//
//  Created by tepmnthar on 07/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "SliderExampleTableViewCell.h"

@implementation SliderExampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.slider.wt_validatorHandler = ^(WTValidatorStatus status) {
        [self updateIndicator:status];
    };
}

@end
