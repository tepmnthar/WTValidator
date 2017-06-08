//
//  WTValidatorCenter.h
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WTValidatable.h"

typedef void (^WTValidatorGroupHandler)(WTValidatorStatus status);

@class WTValidator;
@interface WTValidatorCenter : NSObject

- (void)registerValidator:(WTValidator*)validator forGroupKey:(NSString*)key;
- (void)registerValidators:(NSArray<WTValidator*>*)validators forGroupKey:(NSString*)key;
- (void)registerValidatorGroupHandler:(WTValidatorGroupHandler)groupHandler forGroupKey:(NSString*)key;
- (void)removeValidator:(WTValidator*)validator forGroupKey:(NSString*)key;
- (void)removeAllForGroupKey:(NSString*)key;
- (void)removeAll;

- (void)validateComplete:(WTValidator*)validator status:(WTValidatorStatus)status;

@end
