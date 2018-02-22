//
//  Created by matt on 24/09/12.
//

#import "MGBlockWrapper.h"

/**
* Provides lightweight, blocks based keypath observing.
*/

@interface NSObject (MGObservers)

#pragma mark - Keypath observing

/** @name Keypath observing */

@property (nonatomic, retain) NSMutableDictionary *MGObservers;

/**
On change of the given keypath, perform the given block.

    [box onChangeOf:@"selected" do:^{
        NSLog(@"my selected state changed to: %@", box.selected ? @"ON" : @"OFF");
    }];
*/
- (void)onChangeOf:(NSString *)keypath do:(MGBlock)block;

/**
On change of any of the given keypaths, perform the given block.

    [box onChangeOfAny:@[@"selected", @"highlighted"] do:^{
        NSLog(@"my selected state is: %@", box.selected ? @"ON" : @"OFF");
        NSLog(@"my highlighted state is: %@", box.highlighted ? @"ON" : @"OFF");
    }];
*/
- (void)onChangeOfAny:(NSArray *)keypaths do:(MGBlock)block;

@property (nonatomic, copy) MGBlock onDealloc;

@end
