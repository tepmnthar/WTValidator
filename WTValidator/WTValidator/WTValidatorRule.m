//
//  WTValidatorRule.m
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRule.h"

@interface WTValidatorRule ()
@property (nonatomic, readwrite) WTValidatableType validType;
@end

@implementation WTValidatorRule

- (BOOL)validate:(id)input {
    NSAssert(NO, @"Directly call method on abstract class %@", [self class]);
    return NO;
}
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    if ([self isMemberOfClass:[WTValidatorRule class]]) {
        NSAssert(NO, @"Directly initial abstract class %@", [self class]);
    }
    
    return self;
}
- (instancetype)initWithValidType:(WTValidatableType)validType {
    self = [super init];
    if (!self) return nil;
    
    if ([self isMemberOfClass:[WTValidatorRule class]]) {
        NSAssert(NO, @"Don't call %@ directly, use %@ instead", NSStringFromSelector(_cmd), NSStringFromSelector(@selector(init)));
    }
    
    self.validType = validType;
    
    return self;
}
- (void)validateType:(WTValidatableType)type input:(id)input {
    BOOL valid;
    switch (type) {
        case WTValidatableTypeAny:
            valid = YES;
            break;
        case WTValidatableTypeString:
            valid = [input isKindOfClass:[NSString class]];
            break;
        case WTValidatableTypeNumber:
            valid = [input isEqualToString:@"0"] ? YES : [input intValue] > 0;
            break;
        case WTValidatableTypeComparable:
            valid = [input respondsToSelector:@selector(compare:)];
            break;
    }
    NSAssert(valid, @"input type doesn't match to valid type");
}

@end
