//
//  DetailViewController.m
//  RSS Reader II
//
//  Created by Yan Yang on 2/16/15.
//  Copyright (c) 2015 Yan Yang. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIWebViewDelegate>

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

//- (void)setDetailItem:(id)newDetailItem {
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//            
//        // Update the view.
//        [self configureView];
//    }
//}

- (void)configureView {
    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
    if (_URLArray) {
        
        self.addFavButton.enabled = YES;
        
        self.navigationItem.title = self.URLArray[@"title"];
        
        NSURL *url = [[NSURL alloc] initWithString:self.URLArray[@"link"]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    NSURL *homepage = [NSURL URLWithString:@"http://www.google.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:homepage]];
    self.addFavButton.enabled = NO;
     [self configureView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"popoverSeque"]) {
        UINavigationController *NavigationC = (UINavigationController*)segue.destinationViewController;
        BookmarkTableViewController *BookmarkTC = (BookmarkTableViewController*)NavigationC.topViewController;
        NSLog(@"Hi1");
        BookmarkTC.delegate = self;
        NSLog(@"Hi2");
    }
}

- (void)bookmark:(id)sender sendsURL:(NSURL *)url{
    //change the detailItem to selected item in the popover menu
    self.URLArray = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)sender];
    self.navigationItem.title = self.URLArray[@"title"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (IBAction)addFav:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = (NSArray*)[defaults objectForKey:@"bookmarks"];
    NSMutableArray *newArray = nil;
    
    if (array) {
        newArray = [[NSMutableArray alloc] initWithArray:array];
    } else {
        newArray = [[NSMutableArray alloc] init];
    }
    if (self.URLArray == nil || self.URLArray[@"addToFavorite"] != nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Cannot add item"
                              message:@"Content invalid or already in Bookmark"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }else{
        //add a new key-value to detialItem
        [self.URLArray setValue:@"YES" forKey:@"addToFavorite"];
        [newArray addObject:self.URLArray];
    }
    
    [defaults setObject:newArray forKey:@"bookmarks"];
    
}


@end
