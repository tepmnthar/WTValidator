//
//  WTValidatorPatternExcludeSpecialCharacter.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorPatternExcludeSpecialCharacter.h"

@implementation WTValidatorPatternExcludeSpecialCharacter

@dynamic pattern;
- (NSString *)pattern {
    return @"^[A-Za-z0-9]+$";
}

@end
