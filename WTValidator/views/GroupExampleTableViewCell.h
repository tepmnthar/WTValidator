//
//  GroupExampleTableViewCell.h
//  WTValidator
//
//  Created by tepmnthar on 08/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "ExampleTableViewCell.h"

@interface GroupExampleTableViewCell : ExampleTableViewCell

@property (nonatomic, weak) IBOutlet UISlider* slider;
@property (nonatomic, weak) IBOutlet UITextField* textField;
@property (nonatomic, weak) IBOutlet UITextView* textView;

@property (nonatomic, weak) IBOutlet UILabel* sliderIndicator;
@property (nonatomic, weak) IBOutlet UILabel* textFieldIndicator;
@property (nonatomic, weak) IBOutlet UILabel* textViewIndicator;

@end
