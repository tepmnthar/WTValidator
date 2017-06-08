//
//  WTValidatorRuleRequired.m
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRuleRequired.h"

@implementation WTValidatorRuleRequired

- (instancetype)init {
    self = [super initWithValidType:WTValidatableTypeAny];
    if (!self) return nil;
    
    return self;
}

- (BOOL)validate:(id)input {
    [self validateType:self.validType input:input];

    return !!input;
}

//- (NSUInteger)hash {
//    return [self.class hash];
//}
//- (BOOL)isEqual:(id)object {
//    if (self == object) {
//        return YES;
//    }
//    if ([self class] == [object class]) {
//        return YES;
//    }
//    return NO;
//}

@end
