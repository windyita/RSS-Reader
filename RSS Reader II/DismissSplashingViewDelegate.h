//
//  DismissSplashingViewDelegate.h
//  RSS Reader II
//
//  Created by Yan Yang on 2/23/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DismissSplashingViewDelegate <NSObject>
- (void) dismissSplashing;
- (void) showSplashing:(id)sender;
@end
