//
//  WTValidatorRuleCondition.h
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRule.h"

typedef BOOL (^WTValidatorConditionBlock)(id input);

@interface WTValidatorRuleCondition : WTValidatorRule

- (instancetype)initWithCondition:(WTValidatorConditionBlock)condition;
- (instancetype)init NS_UNAVAILABLE;

@end
