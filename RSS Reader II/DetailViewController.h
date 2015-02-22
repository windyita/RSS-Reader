//
//  DetailViewController.h
//  RSS Reader II
//
//  Created by Yan Yang on 2/16/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkTableViewController.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSMutableDictionary* URLArray;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSDictionary *item;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavButton;
- (IBAction)addFav:(id)sender;



@end

