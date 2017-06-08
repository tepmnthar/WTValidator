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
#import "GroupExampleTableViewCell.h"
#import "WTValidator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.tableView.estimatedRowHeight = 250;
    self.tableView.rowHeight = 250;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"1. test required validator";
            cell.lbDetail.text = @"required";
            [cell.textField setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]]];
            return cell;
            break;
        }
        case 1: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"2. test length validator";
            cell.lbDetail.text = @"length {2, 6}";
            [cell.textField setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMinimumLength:2 maximumLength:6]]];
            return cell;
            break;
        }
        case 2: {
            TextViewExampleTableViewCell* cell = (TextViewExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextViewExampleCell"];
            cell.lbTitle.text = @"3. test condition validator";
            cell.lbDetail.text = @"123";
            [cell.textView setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleCondition alloc] initWithCondition:^BOOL(id input) {
                return [(NSString*)input isEqualToString:@"123"];
            }]]];
            return cell;
            break;
        }
        case 3: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"4. test pattern validator";
            cell.lbDetail.text = @"email pattern";
            [cell.textField setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternEmail alloc] init]]]];
            return cell;
            break;
        }
        case 4: {
            SliderExampleTableViewCell* cell = (SliderExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SliderExampleCell"];
            cell.lbTitle.text = @"5. test required validator";
            cell.lbDetail.text = @"value > 0.5";
            [cell.slider setWt_validator:[WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@0.5 order:NSOrderedDescending]]];
            return cell;
            break;
        }
        case 5: {
            TextFieldExampleTableViewCell* cell = (TextFieldExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextFieldExampleCell"];
            cell.lbTitle.text = @"6. test multiple rules";
            cell.lbDetail.text = @"1. not pure numbers, not pure characters, not pure special characters 2. length {6, 16}";
            NSArray* rules = @[
                               [[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternPassword alloc] init]],
                               [[WTValidatorRuleLength alloc] initWithMinimumLength:6 maximumLength:16]
                               ];
            [cell.textField setWt_validator:[WTValidator validatorWithRules:rules]];
            return cell;
            break;
        }
        case 6: {
            GroupExampleTableViewCell* cell = (GroupExampleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"GroupExampleCell"];
            cell.lbTitle.text = @"7. text group rules";
            cell.lbDetail.text = @"should pass all validation 6, 5, 4";
            NSArray* rules = @[
                               [[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternPassword alloc] init]],
                               [[WTValidatorRuleLength alloc] initWithMinimumLength:6 maximumLength:16]
                               ];
            WTValidator* validator1 = [WTValidator validatorWithRules:rules];
            WTValidator* validator2 = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@0.5 order:NSOrderedDescending]];
            WTValidator* validator3 = [WTValidator validatorWithRule:[[WTValidatorRuleCondition alloc] initWithCondition:^BOOL(id input) {
                return [(NSString*)input isEqualToString:@"123"];
            }]];
            [cell.textField setWt_validator:validator1];
            [cell.slider setWt_validator:validator2];
            [cell.textView setWt_validator:validator3];
            
            WTValidatorCenter* center = [[WTValidatorCenter alloc] init];
            [center registerValidators:@[validator1, validator2, validator3] forGroupKey:@"test"];
            [center registerValidatorGroupHandler:^(WTValidatorStatus status) {
                [cell updateIndicator:status];
            } forGroupKey:@"test"];
            return cell;
            break;
        }
            
        default:
            return nil;
            break;
    }
}

@end
