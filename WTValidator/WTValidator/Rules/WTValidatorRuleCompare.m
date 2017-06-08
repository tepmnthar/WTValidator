//
//  WTValidatorRuleCompare.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorRuleCompare.h"

@interface WTValidatorRuleCompare ()

@property (nonatomic) id comparable;
@property (nonatomic) NSComparisonResult order;
@property (nonatomic) BOOL matches;

@end

@implementation WTValidatorRuleCompare

- (instancetype)initWithComparable:(id)comparable order:(NSComparisonResult)order {
    return [self initWithComparable:comparable order:order matches:YES];
}
- (instancetype)initWithComparable:(id)comparable order:(NSComparisonResult)order matches:(BOOL)matches {
    self = [super initWithValidType:WTValidatableTypeComparable];
    if (!self) return nil;
    
    NSAssert(comparable, @"comparable should not be nil");
    NSAssert([comparable respondsToSelector:@selector(compare:)], @"%@ don't response to %@", [comparable class], NSStringFromSelector(@selector(compare:)));

    self.comparable = comparable;
    self.order = order;
    self.matches = matches;
    
    return self;
}
- (BOOL)validate:(id)input {
    if (!input) {
        return NO;
    }
    [self validateType:self.validType input:input];
    
    NSAssert([self inheritFromCommonAncestorWithObj1:self.comparable obj2:input], @"%@ and %@ don't have common ancestor", [self.comparable class], [input class]);
    
    return !(([input compare:self.comparable] == self.order) ^ self.matches);
}
- (BOOL)inheritFromCommonAncestorWithObj1:(id)obj1 obj2:(id)obj2 {
    Class commonSuperClass = nil;
    Class class2 = [obj2 class];
    
    while (!commonSuperClass && class2) {
        Class class1  = [obj1 class];
        while (!commonSuperClass && class1) {
            if (class1 == class2) {
                commonSuperClass = class1;
            } else {
                class1 = [class1 superclass];
            }
        }
        class2 = [class2 superclass];
    }
    return ![@[[NSObject class], [NSProxy class]] containsObject:commonSuperClass];
}

//- (NSUInteger)hash {
//    NSUInteger hashMatches = self.matches ? 2003 : 2011;
//    return [self.class hash] ^ [self.comparable hash] ^ self.order ^ hashMatches;
//}
//- (BOOL)isEqual:(id)object {
//    if (self == object) {
//        return YES;
//    }
//    if ([self class] == [object class] && self.comparable == ((WTValidatorRuleCompare*)object).comparable && self.order == ((WTValidatorRuleCompare*)object).order && self.matches == ((WTValidatorRuleCompare*)object).matches) {
//        return YES;
//    }
//    return NO;
//}


@end
