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
    if(!_URLArray){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary * dic = (NSMutableDictionary *)[defaults objectForKey:@"last"];
        if(dic){
            _URLArray = dic;
        }
    }
    if (_URLArray) {
        
        self.addFavButton.enabled = YES;
        
                self.navigationItem.title = self.URLArray[@"title"];
            NSURL * url = [NSURL URLWithString:_URLArray[@"link"]];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.webView setScalesPageToFit:YES];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary * array = [[NSMutableDictionary alloc]initWithDictionary:_URLArray];
            [defaults setObject:array forKey:@"last"];
            NSError* err = nil;
            NSURL *docs = [[NSFileManager new] URLForDirectory:NSDocumentDirectory
                                                      inDomain:NSUserDomainMask appropriateForURL:nil
                                                        create:YES error:&err];
            
            NSURL* file = [docs URLByAppendingPathComponent:@"sessions.plist"];
            NSData* data = [[NSData alloc] initWithContentsOfURL:file];
            STSession *sess= (STSession *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            if ([sess.details containsObject:_URLArray]) {
                self.star.image = [UIImage imageNamed:@"star.png"];
                [self.view bringSubviewToFront:self.star];
            }
            else {
                self.star.image = nil;
            }    
}
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor greenColor];
//    [self presentViewController:vc animated:NO completion:^{
//        NSLog(@"Splash screen is showing");
//    }];
//}

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
//        UINavigationController *NavigationC = (UINavigationController*)segue.destinationViewController;
//        BookmarkTableViewController *BookmarkTC = (BookmarkTableViewController*)NavigationC.topViewController;
//        BookmarkTC.delegate = self;
       // [NavigationC.navigationBar setHidden:YES];
        UINavigationController *nvc = segue.destinationViewController;
        BookmarkTableViewController *bvc = (BookmarkTableViewController*)nvc.viewControllers.firstObject;
        bvc.delegate =self;
        UIPopoverPresentationController *popPC = nvc.popoverPresentationController;
        popPC.delegate = self;
        //[nvc.navigationBar setHidden:YES];
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController :(UIPresentationController *)controller{
    return UIModalPresentationNone;
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
        self.star.image = [UIImage imageNamed:@"star.png"];
        [self.view bringSubviewToFront:self.star];
    }
    
    [defaults setObject:newArray forKey:@"bookmarks"];
    
}


- (IBAction)tweet:(id)sender {
    if (_URLArray) {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:[[NSString alloc] initWithFormat:@"My favorite news, %@ : \n%@", _URLArray[@"title"], _URLArray[@"link"]]];
        [self presentViewController:tweet animated:YES completion:nil];
        
    }
}
@end
