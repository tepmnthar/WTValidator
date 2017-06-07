//
//  UIKit+WTValidator.h
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#ifndef UIKit_WTValidator_h
#define UIKit_WTValidator_h

@class WTValidator;

typedef NS_ENUM(NSUInteger, WTValidatorStatus) {
    WTValidatorStatusUncheck,
    WTValidatorStatusPass,
    WTValidatorStatusFail,
};
static inline WTValidatorStatus WTValidatorStatusConverter(BOOL valid) {
    return valid ? WTValidatorStatusPass : WTValidatorStatusFail;
}

typedef void (^WTValidatorHandler)(WTValidatorStatus status);

@protocol UIKitWTValidatorProtocol <NSObject>

@property (nonatomic) WTValidator* wt_validator;
@property (nonatomic, readonly) WTValidatorStatus wt_validatorStatus;
@property (nonatomic, copy) WTValidatorHandler wt_validatorHandler;

- (void)setWt_validator:(WTValidator *)wt_validator;

@end



#endif /* UIKit_WTValidator_h */
