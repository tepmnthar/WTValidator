//
//  WTValidatorPatternPassword.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorPatternPassword.h"

@implementation WTValidatorPatternPassword

@dynamic pattern;
- (NSString *)pattern {
    return @"(?!^[0-9^]+$)(?!^[A-Za-z]+$)(?!^[^A-Za-z0-9]+$)^[^\\s]+$";
}

@end
