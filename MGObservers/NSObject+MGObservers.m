//
//  Created by matt on 24/09/12.
//

#import "NSObject+MGObservers.h"
#import "MGObserver.h"
#import "MGWeakHandler.h"
#import "MGDeallocAction.h"
#import <objc/runtime.h>

static char *MGObserversKey = "MGObserversKey";
//static char *MGEventHandlersKey = "MGEventHandlersKey";
static char *MGDeallocActionKey = "MGDeallocActionKey";

#define MGProxyHandlers @"MGProxyHandlers"

@implementation NSObject (MGObservers)

#pragma mark - Property observing

- (void)onChangeOf:(NSString *)keypath do:(MGBlock)block {

  // get observers for this keypath
  NSMutableArray *observers = self.MGObservers[keypath];
  if (!observers) {
    observers = @[].mutableCopy;
    self.MGObservers[keypath] = observers;

  }

  // make and store an observer
  MGObserver *observer = [MGObserver observerFor:self keypath:keypath block:block];
  [observers addObject:observer];

  __unsafe_unretained id _self = self;
  __unsafe_unretained id _observer = observer;
  observer.onDealloc = ^{
      [_self removeObserver:_observer forKeyPath:keypath];
  };

  // force this object to be thrown in the autorelease pool, and not
  // be possible to be freed immediately by ARC if nothing is retaining the
  // object.  This can cause a KVO exception on x86 if this happens.
  static NSMutableArray *runloopRetainer;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    runloopRetainer = NSMutableArray.new;
  });
  [runloopRetainer addObject:self];
  dispatch_async(dispatch_get_main_queue(), ^{
    [runloopRetainer removeObject:self];
  });
}

- (void)onChangeOfAny:(NSArray *)keypaths do:(MGBlock)block {
  for (NSString *keypath in keypaths) {
    [self onChangeOf:keypath do:block];
  }
}

#pragma mark - Getters

- (NSMutableDictionary *)MGObservers {
  id observers = objc_getAssociatedObject(self, MGObserversKey);
  if (!observers) {
    observers = @{}.mutableCopy;
    self.MGObservers = observers;
  }
  return observers;
}

- (MGBlock)onDealloc {
  MGDeallocAction *wrapper = objc_getAssociatedObject(self, MGDeallocActionKey);
  return wrapper.block;
}

+ (NSString *)globalMGEventNameFor:(NSString *)objectEvent {
    return [objectEvent stringByAppendingString:@"-MGGlobalEvent"];
}

#pragma mark - Setters

- (void)setMGObservers:(NSMutableDictionary *)observers {
  objc_setAssociatedObject(self, MGObserversKey, observers,
      OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setOnDealloc:(MGBlock)block {
  MGDeallocAction *wrapper = objc_getAssociatedObject(self, MGDeallocActionKey);
  if (!wrapper) {
    wrapper = MGDeallocAction.new;
    objc_setAssociatedObject(self, MGDeallocActionKey, wrapper,
        OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  wrapper.block = block;
}

@end
