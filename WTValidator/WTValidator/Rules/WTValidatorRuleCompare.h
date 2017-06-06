//
//  WTValidatorRuleCompare.h
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRule.h"

@interface WTValidatorRuleCompare : WTValidatorRule

- (instancetype)initWithComparable:(id)comparable order:(NSComparisonResult)order;
- (instancetype)initWithComparable:(id)comparable order:(NSComparisonResult)order matches:(BOOL)matches;
- (instancetype)init NS_UNAVAILABLE;

@end
