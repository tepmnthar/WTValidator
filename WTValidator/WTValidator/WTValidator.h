//
//  WTValidator.h
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTValidatorRule.h"
#import "WTValidatorRuleRequired.h"
#import "WTValidatorRuleLength.h"
#import "WTValidatorRuleCondition.h"
#import "WTValidatorRulePattern.h"
#import "WTValidatorRuleCompare.h"
#import "WTValidatorPattern.h"
#import "WTValidatorPatternEmail.h"
#import "WTValidatorPatternNumeric.h"
#import "WTValidatorPatternPassword.h"
#import "WTValidatorPatternExcludeSpecialCharacter.h"
#import "UIKit+WTValidator.h"
#import "UISlider+WTValidator.h"
#import "UITextField+WTValidator.h"
#import "UITextView+WTValidator.h"
#import "WTValidatorCenter.h"

@interface WTValidator : NSObject

/**
 set by WTValidatorCenter
 */
@property (nonatomic, readonly) WTValidatorCenter* center;

+ (instancetype)validatorWithRule:(WTValidatorRule*)rule;
+ (instancetype)validatorWithRules:(NSArray<WTValidatorRule*>*)rules;

- (BOOL)validateInput:(id)input;
- (instancetype)init NS_UNAVAILABLE;

@end
