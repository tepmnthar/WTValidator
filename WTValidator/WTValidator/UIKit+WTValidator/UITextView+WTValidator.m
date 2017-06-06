//
//  UITextView+WTValidator.m
//  WTValidator
//
//  Created by tepmnthar on 06/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import "UITextView+WTValidator.h"
#import <objc/runtime.h>
#import "WTValidator.h"

@interface UITextView ()
@property (nonatomic, readwrite) WTValidatorStatus wt_validatorStatus;
@end

@implementation UITextView (WTValidator)

@dynamic wt_validator, wt_validatorStatus, wt_validatorHandler;
- (WTValidatorStatus)wt_validatorStatus {
    return [objc_getAssociatedObject(self, @selector(wt_validatorStatus)) unsignedIntegerValue];
}
- (void)setWt_validatorStatus:(WTValidatorStatus)wt_validatorStatus {
    NSNumber* status = [NSNumber numberWithUnsignedInteger:wt_validatorStatus];
    objc_setAssociatedObject(self, @selector(wt_validatorStatus), status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (WTValidator *)wt_validator {
    return objc_getAssociatedObject(self, @selector(wt_validator));
}
- (void)setWt_validator:(WTValidator *)wt_validator {
    objc_setAssociatedObject(self, @selector(wt_validator), wt_validator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(wt_validate:) name:UITextViewTextDidChangeNotification object:self];
}
- (void)wt_validate:(NSNotification*)notification {
    if (notification.object != self) {
        return;
    }
    self.wt_validatorStatus = WTValidatorStatusConverter([self.wt_validator validateInput:self.text]);
    if (self.wt_validatorHandler) {
        self.wt_validatorHandler(self.wt_validatorStatus);
    }
}
- (WTValidatorHandler)wt_validatorHandler {
    return objc_getAssociatedObject(self, @selector(wt_validatorHandler));
}
- (void)setWt_validatorHandler:(WTValidatorHandler)wt_validatorHandler {
    objc_setAssociatedObject(self, @selector(wt_validatorHandler), wt_validatorHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
