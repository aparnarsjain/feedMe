//
//  MainViewController.m
//  feedME
//
//  Created by Aparna Jain on 6/12/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "MainViewController.h"
#import "FiltersViewController.h"
#import "YelpClient.h"
#import "Restaurant.h"
#import "RestaurantTableViewCell.h"

NSString * const kYelpConsumerKey = @"1yRnP8xAINxcEzSZG_PqpQ";
NSString * const kYelpConsumerSecret = @"te5gvD2iygESbX2emsSsdnwyvDE";
NSString * const kYelpToken = @"Cn5-LpFi1VRkaFs3y04lBx8AF-Q5xXBW";
NSString * const kYelpTokenSecret = @"_r-qShCvWJdzMWElWR62wxBE2R8";

@interface MainViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *restaurants;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UINavigationController *fnc;
@property (nonatomic, strong)     UISearchBar *searchBar;// = [UISearchBar new];



@end

@implementation MainViewController {
    RestaurantTableViewCell *_stubCell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self fetchDataWithParam];
    }
    return self;
}

- (void) fetchDataWithParam {
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    [self.client searchWithParameters:[self.filters searchParams] success:^(AFHTTPRequestOperation *operation, id response) {
        self.restaurants = [Restaurant restaurantsWithArray:[response objectForKey:@"businesses"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.filters = [[Filters alloc] init];
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(onFilterButtonClick)];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    self.searchBar = [UISearchBar new];
    self.searchBar.showsCancelButton = YES;
    [self.searchBar sizeToFit];
    UIView *barWrapper = [[UIView alloc]initWithFrame:self.searchBar.bounds];
    [barWrapper addSubview:self.searchBar];
    self.navigationItem.titleView = barWrapper;
    self.searchBar.delegate = self;

    

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    FiltersViewController *fvc = [[FiltersViewController alloc] init];
    fvc.filters = self.filters;
    self.fnc = [[UINavigationController alloc] initWithRootViewController:fvc];
    
    UINib *cellNib = [UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"RestaurantTableViewCell"];
    _stubCell = [cellNib instantiateWithOwner:nil options:nil][0];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.searchBar becomeFirstResponder];
    [self fetchDataWithParam];
}
- (void)onFilterButtonClick {
   [self presentViewController:self.fnc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantTableViewCell *restaurantTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantTableViewCell" forIndexPath:indexPath];
    restaurantTableViewCell.restaurant = self.restaurants[indexPath.row];
    return restaurantTableViewCell;
}
- (void)configureCell:(RestaurantTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.lblName.text = self.restaurants[indexPath.row % self.restaurants.count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"--> height: %f", size.height);
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.f;
}

#pragma mark - Search Bar methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.filters.searchTerm = searchBar.text;
    [self fetchDataWithParam];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
//    self.filters.searchTerm = nil;
//    [self fetchDataAndReloadTable];
}


@end
