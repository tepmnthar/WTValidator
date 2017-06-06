//
//  TextViewExampleTableViewCell.m
//  WTValidator
//
//  Created by tepmnthar on 07/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "TextViewExampleTableViewCell.h"

@implementation TextViewExampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.wt_validatorHandler = ^(WTValidatorStatus status) {
        [self updateIndicator:status];
    };
}
- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textView.text = @"";
}

@end
