//
//  WTValidatorPatternNumeric.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorPatternNumeric.h"

@implementation WTValidatorPatternNumeric

@dynamic pattern;
- (NSString *)pattern {
    return @"^[0-9]+$";
}

@end
