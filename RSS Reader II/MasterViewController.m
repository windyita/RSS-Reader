//
//  MasterViewController.m
//  RSS Reader
//
//  Created by Yan Yang on 2/15/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TableViewCell.h"
#import "SharedNetworking.h"


@interface MasterViewController ()
@property NSDictionary* links;
@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadData];
    
    UIRefreshControl *refreshMe = [[UIRefreshControl alloc] init];
    refreshMe.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [refreshMe addTarget:self action:@selector(refreshTable)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshMe;
    
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)downloadData {
    
    
    [[SharedNetworking sharedSharedNetworking] getFeedForURL:nil
                                                     success:^(NSDictionary *dictionary, NSError *error) {
                                                         self.links = dictionary[@"responseData"][@"feed"][@"entries"];
                                                         
                                                         for (NSDictionary *link in self.links){
//                                                             NSLog(@"DownloadeData:%@\n%@\n%@\n%@",
//                                                                   link[@"link"],
//                                                                   link[@"contentSnippet"],
//                                                                   link[@"publisheDate"],
//                                                                   link[@"title"]);
                                                             [self insertNewObject:link];
                                                         }
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             [self.tableView reloadData];
                                                         });
                                                         
                                                     } failure:^{
                                                         UIAlertView *alert = [[UIAlertView alloc]
                                                                               initWithTitle:@"Network Error"
                                                                               message:@"Cannot connect to Internet"
                                                                               delegate:nil
                                                                               cancelButtonTitle:@"OK"
                                                                               otherButtonTitles:nil];
                                                         [alert show];                                                     }];
    if (self.refreshControl.refreshing) {
        [self.refreshControl endRefreshing];
    }
}

-(void)refreshTable{
    [self downloadData];
}

- (void)insertNewObject:(id)sender {
    
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    [self.objects insertObject:sender atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setURLArray:[[NSMutableDictionary alloc] initWithDictionary:object]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //    NSDictionary *issue = [self.objects objectAtIndex:indexPath.row];
    //
    //    cell.title.text = [issue objectForKey:@"title"];
    //    cell.date.text = [issue objectForKey:@"publishedDate"];
    //    return cell;
    
    self.issue = [self.objects objectAtIndex:indexPath.row];
    cell.title.text = [self.issue objectForKey:@"title"];
    cell.content.text = [self.issue objectForKey:@"contentSnippet"];
    
    NSDateFormatter * datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    NSDate *date = [[NSDate alloc] init];
    date = [datef dateFromString:[self.issue objectForKey:@"publishedDate"]];
    [datef setDateFormat:@"MM/dd/yyyy"];
    cell.date.text = [datef stringFromDate:date];
    
    //cell.cellDate.text = [self.issue objectForKey:@"publishedDate"];
    return cell;
    
}





//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

@end
