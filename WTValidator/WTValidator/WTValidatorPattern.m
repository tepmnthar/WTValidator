//
//  WTValidatorPattern.m
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorPattern.h"

@implementation WTValidatorPattern
@dynamic pattern;

- (NSString *)pattern {
    NSAssert(@"don't use pattern on abstract class %@", NSStringFromClass([WTValidatorPattern class]));
    return nil;
}

@end
