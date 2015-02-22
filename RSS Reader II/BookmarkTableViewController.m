//
//  BookmarkTableViewController.m
//  RSS Reader II
//
//  Created by Yan Yang on 2/22/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import "BookmarkTableViewController.h"

@interface BookmarkTableViewController ()

@end

@implementation BookmarkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.numOfBookmarks = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"bookmarks"]];
    NSLog(@"%d",self.numOfBookmarks.count);
    
    if (self.numOfBookmarks) {
        for (int i = 0; i < self.numOfBookmarks.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.numOfBookmarks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookmarkCell" forIndexPath:indexPath];
    NSDictionary *object = self.numOfBookmarks[indexPath.row];
    
    cell.textLabel.text = object[@"title"];
    cell.detailTextLabel.text = object[@"contentSnippet"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = self.numOfBookmarks[indexPath.row][@"link"];
    //send selected item back
    [self.delegate bookmark:self.numOfBookmarks[indexPath.row] sendsURL:[NSURL URLWithString:url]];
    //dismiss the bookmark view
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.numOfBookmarks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //update userdefault
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.numOfBookmarks forKey:@"bookmarks"];
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edit:(id)sender {
    if ([self.tableView isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        [self.tableView setEditing:NO animated:YES];
        
        [self.editButton setTitle:@"Edit"];
        
    }else {
        // Turn on edit mode
        [self.tableView setEditing:YES animated:YES];
        
        [self.editButton setTitle:@"Done"];
    }
}

@end

