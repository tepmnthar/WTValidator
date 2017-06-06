//
//  ExampleTableViewCell.h
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTValidator.h"

@interface ExampleTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* lbTitle;
@property (nonatomic, weak) IBOutlet UILabel* lbDetail;
@property (nonatomic, weak) IBOutlet UILabel* lbIndicator;

- (void)updateIndicator:(WTValidatorStatus)status;

@end
