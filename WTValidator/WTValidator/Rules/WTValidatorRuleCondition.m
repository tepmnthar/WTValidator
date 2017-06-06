//
//  WTValidatorRuleCondition.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRuleCondition.h"

@interface WTValidatorRuleCondition ()
@property (nonatomic, copy) WTValidatorConditionBlock condition;
@end

@implementation WTValidatorRuleCondition

- (instancetype)initWithCondition:(WTValidatorConditionBlock)condition {
    self = [super initWithValidType:WTValidatableTypeAny];
    if (!self) return nil;
    
    NSAssert(condition, @"condition should not be nil");
    self.condition = condition;
    
    return self;
}

- (BOOL)validate:(id)input {
    [self validateType:self.validType input:input];
    
    return self.condition(input);
}


@end
