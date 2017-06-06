//
//  WTValidatorRulePattern.h
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRule.h"
#import "WTValidatorPattern.h"

@interface WTValidatorRulePattern : WTValidatorRule
- (instancetype)initWithPattern:(WTValidatorPattern*)pattern;
- (instancetype)init NS_UNAVAILABLE;
@end
