//
//  MainViewController.m
//  feedME
//
//  Created by Aparna Jain on 6/12/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "MainViewController.h"

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
//@property (nonatomic, strong) CCACustomCell *stubCell;

@end

@implementation MainViewController {
    RestaurantTableViewCell *_stubCell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
//            NSLog(@"value: %@", [response objectForKey:@"businesses"]);
        
            self.restaurants = [Restaurant restaurantsWithArray:[response objectForKey:@"businesses"]];
            [self.tableView reloadData];


        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UISearchBar *searchBar = [UISearchBar new];
    searchBar.showsCancelButton = YES;
    [searchBar sizeToFit];
    UIView *barWrapper = [[UIView alloc]initWithFrame:searchBar.bounds];
    [barWrapper addSubview:searchBar];
    self.navigationItem.titleView = barWrapper;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.rowHeight = 130;
    
    UINib *cellNib = [UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"RestaurantTableViewCell"];
    _stubCell = [cellNib instantiateWithOwner:nil options:nil][0];

    
//    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"RestaurantTableViewCell"];
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
//    [self configureCell:_stubCell atIndexPath:indexPath];
    [_stubCell layoutSubviews];
    
    CGSize size = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"--> height: %f", size.height);
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MovieDetailsViewController *vc = [[MovieDetailsViewController alloc] init];
//    vc.movie = self.movies[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
