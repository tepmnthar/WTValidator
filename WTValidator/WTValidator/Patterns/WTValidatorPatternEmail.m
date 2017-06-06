//
//  WTValidatorPatternEmail.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorPatternEmail.h"

@implementation WTValidatorPatternEmail

@dynamic pattern;
- (NSString *)pattern {
    return @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$";
}

@end
