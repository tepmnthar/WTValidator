//
//  WTValidatorTests.m
//  WTValidatorTests
//
//  Created by tepmnthar on 05/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WTValidator.h"

@interface WTValidatorTests : XCTestCase

@end

@implementation WTValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testRules {
    {
        NSArray<WTValidatorRule*>* rules = @[[WTValidatorRuleRequired alloc], [WTValidatorRuleRequired alloc]];
        WTValidator* validator = [WTValidator validatorWithRules:rules];
        BOOL valid = [validator validateInput:@"123"];
        XCTAssert(valid == YES);
    }
    
    {
        NSArray<WTValidatorRule*>* rules = @[[WTValidatorRuleRequired alloc], [WTValidatorRuleRequired alloc]];
        WTValidator* validator = [WTValidator validatorWithRules:rules];
        BOOL valid = [validator validateInput:nil];
        XCTAssert(valid == NO);
    }
}
- (void)testRequired {
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
        BOOL valid = [validator validateInput:@"123"];
        XCTAssert(valid == YES);
    }
    
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
        BOOL valid = [validator validateInput:nil];
        XCTAssert(valid == NO);
    }
}
- (void)testLength {
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMinimumLength:2 maximumLength:3]];
        BOOL valid = [validator validateInput:@"123"];
        BOOL invalid = [validator validateInput:@"1"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithSpecifiedLength:3]];
        BOOL valid = [validator validateInput:@"123"];
        BOOL invalid = [validator validateInput:@"1"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] init]];
        BOOL valid = [validator validateInput:@"123"];
        XCTAssert(valid == YES);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMinimumLength:2]];
        BOOL valid = [validator validateInput:@"123"];
        BOOL invalid = [validator validateInput:@"1"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMaximumLength:3]];
        BOOL valid = [validator validateInput:@"123"];
        BOOL invalid = [validator validateInput:@"1234"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        XCTAssertThrows([WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMinimumLength:3 maximumLength:2]]);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMinimumLength:2 maximumLength:3]];
        XCTAssertThrows([validator validateInput:@[]]);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleLength alloc] initWithMinimumLength:2 maximumLength:3]];
        XCTAssert([validator validateInput:nil] == NO);
    }
}
- (void)testCondition {
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCondition alloc] initWithCondition:^BOOL(id input) {
            return [input isEqualToString:@"123"];
        }]];
        BOOL valid = [validator validateInput:@"123"];
        BOOL invalid = [validator validateInput:@"1234"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        XCTAssertThrows([WTValidator validatorWithRule:[[WTValidatorRuleCondition alloc] initWithCondition:nil]]);
    }
}
- (void)testPattern {
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternEmail alloc] init]]];
        BOOL valid = [validator validateInput:@"632897649@qq.com"];
        BOOL invalid = [validator validateInput:@"@qq.com"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternNumeric alloc] init]]];
        BOOL valid = [validator validateInput:@"632897649"];
        BOOL invalid = [validator validateInput:@"632897649@qq.com"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternPassword alloc] init]]];
        BOOL valid = [validator validateInput:@"632897649@"];
        BOOL invalid = [validator validateInput:@"632897649"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRulePattern alloc] initWithPattern:[[WTValidatorPatternExcludeSpecialCharacter alloc] init]]];
        BOOL valid = [validator validateInput:@"867fastf7878"];
        BOOL invalid = [validator validateInput:@"khdfu^234"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        XCTAssertThrows([WTValidator validatorWithRule:[[WTValidatorRulePattern alloc] initWithPattern:nil]]);
    }
}
- (void)testCompare {
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@"123" order:NSOrderedSame matches:YES]];
        BOOL valid = [validator validateInput:@"123"];
        BOOL invalid = [validator validateInput:@"@321"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@"123" order:NSOrderedDescending]];
        BOOL valid = [validator validateInput:@"321"];
        BOOL invalid = [validator validateInput:@"123"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@"123" order:NSOrderedDescending matches:NO]];
        BOOL valid = [validator validateInput:@"123"];
        BOOL invalid = [validator validateInput:@"@321"];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:[NSDate dateWithTimeIntervalSince1970:0] order:NSOrderedDescending]];
        BOOL valid = [validator validateInput:[NSDate dateWithTimeIntervalSinceNow:0]];
        BOOL invalid = [validator validateInput:[NSDate dateWithTimeIntervalSince1970:0]];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@3.14 order:NSOrderedDescending]];
        BOOL valid = [validator validateInput:@233];
        BOOL invalid = [validator validateInput:@0.618];
        XCTAssert(valid == YES);
        XCTAssert(invalid == NO);
    }
    {
        XCTAssertThrows([WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:nil order:NSOrderedSame]]);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@3.14 order:NSOrderedAscending]];
        XCTAssert([validator validateInput:nil] == NO);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@3.14 order:NSOrderedAscending]];
        XCTAssertThrows([validator validateInput:@[]]);
    }
    {
        WTValidator* validator = [WTValidator validatorWithRule:[[WTValidatorRuleCompare alloc] initWithComparable:@3.14 order:NSOrderedAscending]];
        XCTAssertThrows([validator validateInput:@"123"]);
    }
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
