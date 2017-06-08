//
//  WTValidatable.h
//  WTValidator
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#ifndef WTValidatable_h
#define WTValidatable_h

typedef NS_ENUM(NSUInteger, WTValidatableType) {
    WTValidatableTypeAny,
    WTValidatableTypeNumber,
    WTValidatableTypeString,
    WTValidatableTypeComparable,
};
typedef NS_ENUM(NSUInteger, WTValidatorStatus) {
    WTValidatorStatusUncheck,
    WTValidatorStatusPass,
    WTValidatorStatusFail,
};
static inline WTValidatorStatus WTValidatorStatusConverter(BOOL valid) {
    return valid ? WTValidatorStatusPass : WTValidatorStatusFail;
}
#endif /* WTValidatable_h */
