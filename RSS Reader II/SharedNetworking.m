//
//  SharedNetworking.m
//  RSS Reader
//
//  Created by Yan Yang on 2/16/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import "SharedNetworking.h"

@implementation SharedNetworking

///-------------------------------------------------
#pragma mark - Initialization
///-------------------------------------------------
+ (id)sharedSharedNetworking
{
    static dispatch_once_t pred;
    static SharedNetworking *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init
{
    if (self = [super init]){
        
    }
    return self;
}

///-------------------------------------------------
#pragma mark - Requests
- (void)getFeedForURL:(NSString*)url
              success:(void (^)(NSDictionary *dictionary, NSError *error))successCompletion
              failure:(void (^)(void))failureCompletion
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *webUrl = @"http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=8&q=http%3A%2F%2Fnews.google.com%2Fnews%3Foutput%3Drss";
    //if (![self isNetworkEnabled]) return;
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:webUrl]
                                 completionHandler:^(NSData *data,
                                                     NSURLResponse *response,
                                                     NSError *error) {
                                     
                                     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                     // handle response
                                     NSLog(@"Data:%@",data);
                                     NSLog(@"Response:%@",response);
                                     NSLog(@"Error:%@",[error localizedDescription]);
                                     
                                     NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                                     if (httpResp.statusCode == 200) {
                                         NSError *jsonError;
                                         
                                         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                                         
                                         NSLog(@"DownloadeData:%@",dict);
                                         
                                         successCompletion(dict,nil);
                                     } else {
                                         NSLog(@"Fail Not 200:");
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             if (failureCompletion) failureCompletion();
                                         });
                                     }
                                 }] resume];
}

@end
