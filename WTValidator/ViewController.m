//
//  ViewController.m
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "ViewController.h"
#import "SliderExampleTableViewCell.h"
#import "TextFieldExampleTableViewCell.h"
#import "TextViewExampleTableViewCell.h"
#import "WTValidator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.estimatedRowHeight = 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"test required validator";
            cell.lbDetail.text = @"required";
            [cell.textField setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]]];
            return cell;
            break;
        }
        case 1: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"test length validator";
            cell.lbDetail.text = @"length {2, 6}";
            [cell.textField setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMinimumLength:2 maximumLength:6]]];
            return cell;
            break;
        }
        case 2: {
            TextViewExampleTableViewCell* cell = (TextViewExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextViewExampleCell"];
            cell.lbTitle.text = @"test condition validator";
            cell.lbDetail.text = @"123";
            [cell.textView setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleCondition alloc] initWithCondition:^BOOL(id input) {
                return [(NSString*)input isEqualToString:@"123"];
            }]]];
            return cell;
            break;
        }
        case 3: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"test pattern validator";
            cell.lbDetail.text = @"email pattern";
            [cell.textField setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternEmail alloc] init]]]];
            return cell;
            break;
        }
        case 4: {
            SliderExampleTableViewCell* cell = (SliderExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SliderExampleCell"];
            cell.lbTitle.text = @"test required validator";
            cell.lbDetail.text = @"value > 0.5";
            [cell.slider setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@0.5 order:NSOrderedDescending]]];
            return cell;
            break;
        }
        case 5: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"test multiple rules";
            cell.lbDetail.text = @"1. not pure numbers, not pure characters, not pure special characters 2. length {6, 16}";
            NSArray* rules = @[
                               [[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternPassword alloc] init]],
                               [[WTValidatorRuleLength alloc] initWithMinimumLength:6 maximumLength:16]
                               ];
            [cell.textField setWt_validator:[WTValidator validatorWithRules:rules]];
            return cell;
            break;
        }
            
        default:
            return nil;
            break;
    }
}

@end
