//
//  Created by matt on 2/04/14.
//

#import <Foundation/Foundation.h>

@interface MGWeakHandler : NSObject

@property (nonatomic, weak) NSDictionary *dict;

+ (instancetype)handlerWithDict:(NSDictionary *)dict;

@end
