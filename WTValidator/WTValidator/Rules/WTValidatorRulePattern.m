//
//  WTValidatorRulePattern.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRulePattern.h"

@interface WTValidatorRulePattern ()
@property (nonatomic) NSString* pattern;
@end
@implementation WTValidatorRulePattern

- (instancetype)initWithPattern:(WTValidatorPattern *)pattern {
    self = [super initWithValidType:WTValidatableTypeString];
    if (!self) return nil;
    
    NSAssert(pattern, @"pattern should not be nil");

    self.pattern = pattern.pattern;
    
    return self;
}
- (BOOL)validate:(id)input {
    [self validateType:self.validType input:input];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.pattern];
    return [predicate evaluateWithObject: (NSString*)input];
}

@end
