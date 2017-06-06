
//
//  WTValidator.m
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidator.h"

@interface WTValidator ()

@property (nonatomic) NSMutableArray<WTValidatorRule*>* rules;

@end

@implementation WTValidator

+ (instancetype)validatorWithRule:(WTValidatorRule *)rule {
    WTValidator* validator = [[WTValidator alloc] initInner];
    
    [validator.rules addObject:rule];
    
    return validator;
}

+ (instancetype)validatorWithRules:(NSArray<WTValidatorRule *> *)rules {
    WTValidator* validator = [[WTValidator alloc] initInner];
    
    [validator.rules addObjectsFromArray:rules];
    
    return validator;
}

- (instancetype)initInner {
    self = [super init];
    if (!self) return nil;
    
    self.rules = [NSMutableArray array];
    
    return self;
}

- (BOOL)validateInput:(id)input {
    __block BOOL flag = YES;
    [self.rules enumerateObjectsUsingBlock:^(WTValidatorRule * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj validate:input]) {
            flag = NO;
            *stop = YES;
        }
    }];
    return flag;
}

@end
