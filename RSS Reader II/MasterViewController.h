//
//  MasterViewController.h
//  RSS Reader II
//
//  Created by Yan Yang on 2/16/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol dismissViewProtocol <NSObject>
- (void) dismissView: (id)sender sendObject: (BOOL)finished;
@end

@class DetailViewController;

@interface MasterViewController : UITableViewController  <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSDictionary *issue;
@property (nonatomic, weak) id<dismissViewProtocol> dismissdele;

@end

