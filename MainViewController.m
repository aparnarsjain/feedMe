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

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 130;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"RestaurantTableViewCell"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MovieDetailsViewController *vc = [[MovieDetailsViewController alloc] init];
//    vc.movie = self.movies[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
