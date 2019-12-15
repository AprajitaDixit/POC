//
//  FeedViewController.m
//  POC_Example
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 aprajitadixit. All rights reserved.
//

#import "FeedViewController.h"
#import "Utility.h"

@interface FeedViewController ()

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) UIActivityIndicatorView *indicator;
@property(strong, nonatomic) UIButton *retryButton;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTableView];
    [self fetchDataAndUpdateModel];
}

-(void)setUpTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views: NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views: NSDictionaryOfVariableBindings(_tableView)]];

    [self addPullToRefeshButton];
    _viewModel = [[FeedViewModel alloc]init];
}

-(void)addPullToRefeshButton {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)refreshData:(UIRefreshControl *)refreshControl {
    [self fetchDataAndUpdateModel];
    [refreshControl endRefreshing];
}

-(void)fetchDataAndUpdateModel {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if ([reach isReachable] == false) {
        [self.tableView setHidden:true];
        [Utility showAlert:@"Whoops!" message:@"Seems like you are not connected to the internet." controller:self completion:^(UIAlertAction *action) {
            self.retryButton = [Utility addRetryButton: self.view];
            [self.retryButton addTarget:self
                        action:@selector(callApiAgain:)
            forControlEvents:UIControlEventTouchUpInside];
        }];
        return;
    }
    [self callAPI];
}

-(void)callAPI {
    self.indicator = [Utility showActivityIndicator:self.view];
    [self.indicator startAnimating];
    [self.tableView setHidden:true];
    [_viewModel fetchFeedsFromApiwithCompletion:^(NSArray<FeedModel *> *result,
                                                  NSString* title, NSError* error) {
        if (error == nil) {
            self.viewModel.dataSource.feedArray = result;
            dispatch_sync(dispatch_get_main_queue(),^{
                if (title && ![title isEqual: [NSNull null]]) {
                    self.title = title;
                }
                [self.indicator stopAnimating];
                [self.tableView setHidden:false];
                [self.retryButton setHidden:true];
                [self reloadData];
            });
        } else {
            [self.indicator stopAnimating];
            [Utility showAlert:@"" message:error.description controller:self completion:nil];
            [self.retryButton setHidden:false];
        }
    }];
}

-(void)reloadData {
    [self.tableView setDataSource: self.viewModel.dataSource];
    [self.tableView setDelegate: self.viewModel.dataSource];
    [self.tableView reloadData];
}

-(void)callApiAgain:(UIButton*)sender {
    [self fetchDataAndUpdateModel];
}

@end
