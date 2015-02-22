//
//  BookmarkTableViewController.h
//  RSS Reader II
//
//  Created by Yan Yang on 2/22/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookmarkToWebViewDelegate <NSObject>
- (void) bookmark:(id)sender sendsURL:(NSURL*)url;
@end

@interface BookmarkTableViewController : UITableViewController

@property NSMutableArray *numOfBookmarks;

@property (weak, nonatomic) id<BookmarkToWebViewDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
//- (IBAction)edit:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)edit:(id)sender;



@end
