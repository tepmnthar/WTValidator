//
//  WTValidatorCenterTests.m
//  WTValidatorTests
//
//  Created by tepmnthar on 08/06/2017.
//  Copyright © 2017 tepmnthar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WTValidator.h"

static NSString* const WTValidatorGroupDictionaryKeyStatus = @"status";
static NSString* const WTValidatorGroupDictionaryKeyValidators = @"validators";
static NSString* const WTValidatorGroupDictionaryKeyGroupHandler = @"groupHandler";

@interface WTValidatorCenter (test)
@property (nonatomic) NSMutableDictionary<NSString*, NSMutableDictionary*>* validatorGroupDictionary;
- (void)updateStatus:(WTValidatorStatus)status forKey:(NSString*)key hash:(NSUInteger)hash;
- (WTValidatorStatus)checkStatusForKey:(NSString*)key;
- (void)callGroupHandler:(WTValidatorStatus)status forKey:(NSString*)key;
@end

@interface WTValidatorCenterTests : XCTestCase

@end

@implementation WTValidatorCenterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDataStructure {
    WTValidatorCenter* center = [[WTValidatorCenter alloc] init];
    WTValidator* validator1_1 = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
    WTValidator* validator1_2 = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
    [center registerValidator:validator1_1 forGroupKey:@"test1"];
    [center registerValidator:validator1_2 forGroupKey:@"test1"];
    XCTAssert([center.validatorGroupDictionary count] == 1);
    
    [center registerValidatorGroupHandler:nil forGroupKey:@"test1"];
    XCTAssert(![center.validatorGroupDictionary objectForKey:@"test1"][WTValidatorGroupDictionaryKeyGroupHandler]);
    
    [center registerValidatorGroupHandler:^(WTValidatorStatus status) {
        
    } forGroupKey:@"test1"];
    XCTAssert([center.validatorGroupDictionary objectForKey:@"test1"][WTValidatorGroupDictionaryKeyGroupHandler]);
    
    WTValidator* validator2 = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
    [center registerValidator:validator2 forGroupKey:@"test2"];
    XCTAssert([center.validatorGroupDictionary count] == 2);
    
    [center removeValidator:validator1_2 forGroupKey:@"test1"];
    XCTAssert([center.validatorGroupDictionary count] == 2);
    
    [center removeValidator:validator2 forGroupKey:@"test1"];
    XCTAssert([center.validatorGroupDictionary count] == 2);
    
    [center removeValidator:validator2 forGroupKey:@"test2"];
    XCTAssert([center.validatorGroupDictionary count] == 1);
    
    [center registerValidators:@[validator1_1, validator1_2, validator2] forGroupKey:@"test3"];
    XCTAssert([center.validatorGroupDictionary count] == 2);
    
    [center removeAllForGroupKey:@"test1"];
    XCTAssert([center.validatorGroupDictionary count] == 1);
    
    [center removeAll];
    XCTAssert([center.validatorGroupDictionary count] == 0);
}

- (void)testGroupValidate {
    __block WTValidatorStatus test2;
    WTValidatorCenter* center = [[WTValidatorCenter alloc] init];
    WTValidator* validator1_1 = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
    WTValidator* validator1_2 = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
    WTValidator* validator2 = [WTValidator validatorWithRule:[[WTValidatorRuleRequired alloc] init]];
    
    [center registerValidator:validator1_1 forGroupKey:@"test1"];
    [center registerValidator:validator1_2 forGroupKey:@"test1"];
    [center registerValidatorGroupHandler:nil forGroupKey:@"test1"];
    
    [center registerValidator:validator2 forGroupKey:@"test2"];
    [center registerValidatorGroupHandler:^(WTValidatorStatus status) {
        test2 = status;
    } forGroupKey:@"test2"];
    
    [center registerValidators:@[validator1_1, validator1_2, validator2] forGroupKey:@"test3"];
    
    XCTAssert([center checkStatusForKey:@"test1"] == WTValidatorStatusUncheck);
    XCTAssert([center checkStatusForKey:@"test2"] == WTValidatorStatusUncheck);
    XCTAssert([center checkStatusForKey:@"test3"] == WTValidatorStatusUncheck);
    XCTAssert(test2 == WTValidatorStatusUncheck);
    
    [center validateComplete:validator1_1 status:WTValidatorStatusFail];
    XCTAssert([center checkStatusForKey:@"test1"] == WTValidatorStatusFail);
    XCTAssert([center checkStatusForKey:@"test2"] == WTValidatorStatusUncheck);
    XCTAssert([center checkStatusForKey:@"test3"] == WTValidatorStatusFail);
    
    [center validateComplete:validator2 status:WTValidatorStatusPass];
    XCTAssert([center checkStatusForKey:@"test1"] == WTValidatorStatusFail);
    XCTAssert([center checkStatusForKey:@"test2"] == WTValidatorStatusPass);
    XCTAssert([center checkStatusForKey:@"test3"] == WTValidatorStatusFail);
    XCTAssert(test2 == WTValidatorStatusPass);
    
    [center validateComplete:validator1_1 status:WTValidatorStatusPass];
    [center validateComplete:validator1_2 status:WTValidatorStatusPass];
    XCTAssert([center checkStatusForKey:@"test1"] == WTValidatorStatusPass);
    XCTAssert([center checkStatusForKey:@"test2"] == WTValidatorStatusPass);
    XCTAssert([center checkStatusForKey:@"test3"] == WTValidatorStatusPass);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
