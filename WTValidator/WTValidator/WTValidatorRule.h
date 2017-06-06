//
//  WTValidatorRule.h
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTValidatable.h"

@interface WTValidatorRule : NSObject
@property (nonatomic, readonly) WTValidatableType validType;

/**
 protected initializer

 @param validType valid type
 @return instance
 */
- (instancetype)initWithValidType:(WTValidatableType)validType;

- (BOOL)validate:(id)input;
- (void)validateType:(WTValidatableType)type input:(id)input;

@end
