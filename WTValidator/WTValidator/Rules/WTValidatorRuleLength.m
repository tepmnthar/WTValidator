//
//  WTValidatorRuleLength.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRuleLength.h"

@interface WTValidatorRuleLength ()

@property (nonatomic) NSUInteger min;
@property (nonatomic) NSUInteger max;

@end

@implementation WTValidatorRuleLength

- (instancetype)init {
    return [self initWithMinimumLength:0 maximumLength:NSUIntegerMax];
}
- (instancetype)initWithSpecifiedLength:(NSUInteger)specifiedLength {
    return [self initWithMinimumLength:specifiedLength maximumLength:specifiedLength];
}
- (instancetype)initWithMinimumLength:(NSUInteger)minimumLength {
    return [self initWithMinimumLength:minimumLength maximumLength:NSUIntegerMax];
}
- (instancetype)initWithMaximumLength:(NSUInteger)maximumLength {
    return [self initWithMinimumLength:0 maximumLength:maximumLength];
}
- (instancetype)initWithMinimumLength:(NSUInteger)minimumLength maximumLength:(NSUInteger)maximumLength {
    self = [super initWithValidType:WTValidatableTypeString];
    if (!self) return nil;
    
    NSAssert(minimumLength <= maximumLength, @"invalid maximumLength maximumLength value");
    
    self.min = minimumLength;
    self.max = maximumLength;
    
    return self;
}

- (BOOL)validate:(id)input {
    if (!input) {
        return NO;
    }
    [self validateType:self.validType input:input];

    NSUInteger length = [(NSString*)input length];
    BOOL valid = self.min <= length && length <= self.max;
    return valid;
}

@end
