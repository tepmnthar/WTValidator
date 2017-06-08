//
//  WTValidatorCenter.m
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "WTValidatorCenter.h"
#import "WTValidator.h"

@interface WTValidator (WTValidatorCenter)
@property (nonatomic, readwrite) WTValidatorCenter* center;
@end

static NSString* const WTValidatorGroupDictionaryKeyStatus = @"status";
static NSString* const WTValidatorGroupDictionaryKeyValidators = @"validators";
static NSString* const WTValidatorGroupDictionaryKeyGroupHandler = @"groupHandler";

@interface WTValidatorCenter ()
/**
 结构为：
 {
     key: {
         status: {
             validatorHash: WTValidatorStatus,
             ...
         },
         validators: {
             validatorHash: WTValidator
             ...
         },
         groupHandler: WTValidatorGroupHandler
     },
     ...
 }
 struct WTValidatorGroup {
     var status: [UInt : WTValidatorStatus],
     var validators: [UInt : WTValidator],
     var groupHandler: WTValidatorGroupHandler
 }
 var validatorGroupDictionary: [String : WTValidatorGroup]
 */
@property (nonatomic) NSMutableDictionary<NSString*, NSMutableDictionary*>* validatorGroupDictionary;
@end
@implementation WTValidatorCenter
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.validatorGroupDictionary = [NSMutableDictionary dictionary];
    
    return self;
}

- (void)registerValidator:(WTValidator *)validator forGroupKey:(NSString *)key {
    NSMutableDictionary* validatorGroup = [self.validatorGroupDictionary objectForKey:key];
    if (!validatorGroup) {
        validatorGroup = [NSMutableDictionary dictionary];
        [self.validatorGroupDictionary setObject:validatorGroup forKey:key];
        [validatorGroup setObject:[NSMutableDictionary dictionary] forKey:WTValidatorGroupDictionaryKeyStatus];
        [validatorGroup setObject:[NSMutableDictionary dictionary] forKey:WTValidatorGroupDictionaryKeyValidators];
    }
    [validatorGroup[WTValidatorGroupDictionaryKeyStatus] setObject:[NSNumber numberWithUnsignedInteger:WTValidatorStatusUncheck] forKey:[NSNumber numberWithUnsignedInteger:[validator hash]]];
    [validatorGroup[WTValidatorGroupDictionaryKeyValidators] setObject:[NSValue valueWithNonretainedObject:validator] forKey:[NSNumber numberWithUnsignedInteger:[validator hash]]];
    [self updateValidatorCenter:validator];
}
- (void)registerValidators:(NSArray<WTValidator *> *)validators forGroupKey:(NSString *)key {
    NSMutableDictionary* validatorGroup = [self.validatorGroupDictionary objectForKey:key];
    if (!validatorGroup) {
        validatorGroup = [NSMutableDictionary dictionary];
        [self.validatorGroupDictionary setObject:validatorGroup forKey:key];
        [validatorGroup setObject:[NSMutableDictionary dictionary] forKey:WTValidatorGroupDictionaryKeyStatus];
        [validatorGroup setObject:[NSMutableDictionary dictionary] forKey:WTValidatorGroupDictionaryKeyValidators];
    }
    [validators enumerateObjectsUsingBlock:^(WTValidator * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [validatorGroup[WTValidatorGroupDictionaryKeyStatus] setObject:[NSNumber numberWithUnsignedInteger:WTValidatorStatusUncheck] forKey:[NSNumber numberWithUnsignedInteger:[obj hash]]];
        [validatorGroup[WTValidatorGroupDictionaryKeyValidators] setObject:[NSValue valueWithNonretainedObject:obj] forKey:[NSNumber numberWithUnsignedInteger:[obj hash]]];
        [self updateValidatorCenter:obj];
    }];
}
- (void)registerValidatorGroupHandler:(WTValidatorGroupHandler)groupHandler forGroupKey:(NSString *)key {
    if (!groupHandler) {
        return;
    }
    NSMutableDictionary* validatorGroup = [self.validatorGroupDictionary objectForKey:key];
    if (!validatorGroup) {
        validatorGroup = [NSMutableDictionary dictionary];
        [self.validatorGroupDictionary setObject:validatorGroup forKey:key];
        [validatorGroup setObject:[NSMutableDictionary dictionary] forKey:WTValidatorGroupDictionaryKeyStatus];
        [validatorGroup setObject:[NSMutableDictionary dictionary] forKey:WTValidatorGroupDictionaryKeyValidators];
    }
    [validatorGroup setObject:groupHandler forKey:WTValidatorGroupDictionaryKeyGroupHandler];
}
- (void)removeValidator:(WTValidator *)validator forGroupKey:(NSString *)key {
    NSMutableDictionary* validatorGroup = [self.validatorGroupDictionary objectForKey:key];
    if (validatorGroup) {
        [validatorGroup[WTValidatorGroupDictionaryKeyStatus] removeObjectForKey:[NSNumber numberWithUnsignedInteger:[validator hash]]];
        [validatorGroup[WTValidatorGroupDictionaryKeyValidators] removeObjectForKey:[NSNumber numberWithUnsignedInteger:[validator hash]]];
        if ([validatorGroup[WTValidatorGroupDictionaryKeyValidators] count] == 0) {
            [self.validatorGroupDictionary removeObjectForKey:key];
        }
    }
}
- (void)removeAllForGroupKey:(NSString *)key {
    [self.validatorGroupDictionary removeObjectForKey:key];
}
- (void)removeAll {
    [self.validatorGroupDictionary removeAllObjects];
}

- (void)validateComplete:(WTValidator *)validator status:(WTValidatorStatus)status{
    [self.validatorGroupDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        WTValidator* storedValidator = [[obj[WTValidatorGroupDictionaryKeyValidators] objectForKey:[NSNumber numberWithUnsignedInteger:[validator hash]]] nonretainedObjectValue];
        if (storedValidator && storedValidator == validator) {
            [self updateStatus:status forKey:key hash:[validator hash]];
            WTValidatorStatus groupStatus = [self checkStatusForKey:key];
            [self callGroupHandler:groupStatus forKey:key];
        }
    }];
}
- (void)updateStatus:(WTValidatorStatus)status forKey:(NSString*)key hash:(NSUInteger)hash {
    NSMutableDictionary* validatorGroup = [self.validatorGroupDictionary objectForKey:key];
    if (validatorGroup) {
        [validatorGroup[WTValidatorGroupDictionaryKeyStatus] setObject:[NSNumber numberWithUnsignedInteger:status] forKey:[NSNumber numberWithUnsignedInteger:hash]];
    } else {
        NSAssert(NO, @"validatorGroupDictionary data structure damaged");
    }
}
- (WTValidatorStatus)checkStatusForKey:(NSString*)key {
    NSMutableDictionary* validatorGroup = [self.validatorGroupDictionary objectForKey:key];
    if (validatorGroup) {
        __block BOOL unchecked = YES;
        __block BOOL passed = YES;
        [validatorGroup[WTValidatorGroupDictionaryKeyStatus] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            WTValidatorStatus status = [obj unsignedIntegerValue];
            switch (status) {
                case WTValidatorStatusUncheck:
                    passed = NO;
                    break;
                case WTValidatorStatusPass:
                    unchecked = NO;
                    break;
                case WTValidatorStatusFail:
                    unchecked = NO;
                    passed = NO;
                    break;
            }
        }];
        if (passed) {
            return WTValidatorStatusPass;
        } else {
            if (unchecked) {
                return WTValidatorStatusUncheck;
            } else {
                return WTValidatorStatusFail;
            }
        }
    } else {
        NSAssert(NO, @"validatorGroupDictionary data structure damaged");
        return WTValidatorStatusUncheck;
    }
}
- (void)callGroupHandler:(WTValidatorStatus)status forKey:(NSString*)key {
    NSMutableDictionary* validatorGroup = [self.validatorGroupDictionary objectForKey:key];
    if (validatorGroup) {
        WTValidatorGroupHandler groupHandler = [validatorGroup objectForKey:WTValidatorGroupDictionaryKeyGroupHandler];
        if (groupHandler) {
            groupHandler(status);
        }
    } else {
        NSAssert(NO, @"validatorGroupDictionary data structure damaged");
    }
}
- (void)updateValidatorCenter:(WTValidator*)validator {
    NSAssert(!validator.center || validator.center == self, @"validator already registed");
    validator.center = self;
}

@end
