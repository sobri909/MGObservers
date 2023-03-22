//
//  Created by matt on 24/08/12.
//

#import <Foundation/Foundation.h>

typedef void(^MGBlock)(void);
typedef void(^MGBlockWithContext)(id context);

@interface MGBlockWrapper : NSObject

@property (nonatomic, copy) MGBlock block;

+ (MGBlockWrapper *)wrapperForBlock:(MGBlock)block;
- (void)doit;

@end
