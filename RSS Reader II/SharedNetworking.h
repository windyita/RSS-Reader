//
//  SharedNetworking.h
//  RSS Reader
//
//  Created by Yan Yang on 2/16/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface SharedNetworking : NSObject
+ (id)sharedSharedNetworking;

- (void)getFeedForURL:(NSString*)url
              success:(void (^)(NSDictionary *dict, NSError *error))successCompletion
              failure:(void (^)(void))failureCompletion;


@end
