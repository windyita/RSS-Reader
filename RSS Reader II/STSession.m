//
//  STSession.m
//  RSS Reader II
//
//  Created by Yan Yang on 2/23/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import "STSession.h"

@implementation STSession

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.details forKey:@"details"];
    
}
- (id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    self.details = [decoder decodeObjectForKey:@"details"];
    return self;
}

@end
