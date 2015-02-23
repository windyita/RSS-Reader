//
//  DetailViewController.h
//  RSS Reader II
//
//  Created by Yan Yang on 2/16/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkTableViewController.h"
#import "MasterViewController.h"
#import "STSession.h"
#import <Social/Social.h>

@interface DetailViewController : UIViewController <BookmarkToWebViewDelegate, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSMutableDictionary* URLArray;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSDictionary *item;

@property (weak, nonatomic) IBOutlet UIImageView *star;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavButton;
- (IBAction)addFav:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actind;
@property UIViewController * splash;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
- (IBAction)tweet:(id)sender;



@end

