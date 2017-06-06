//
//  WTValidatorRuleLength.h
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRule.h"

@interface WTValidatorRuleLength : WTValidatorRule

- (instancetype)initWithSpecifiedLength: (NSUInteger)specifiedLength;
- (instancetype)initWithMinimumLength:(NSUInteger)minimumLength;
- (instancetype)initWithMaximumLength:(NSUInteger)maximumLength;
- (instancetype)initWithMinimumLength:(NSUInteger)minimumLength maximumLength:(NSUInteger)maximumLength;

@end
