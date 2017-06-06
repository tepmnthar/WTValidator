//
//  TextFieldExampleTableViewCell.m
//  WTValidator
//
//  Created by tepmnthar on 07/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "TextFieldExampleTableViewCell.h"

@implementation TextFieldExampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textField.wt_validatorHandler = ^(WTValidatorStatus status) {
        [self updateIndicator:status];
    };
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textField.text = @"";
}

@end
