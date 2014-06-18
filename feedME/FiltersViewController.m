//
//  FiltersViewController.m
//  feedME
//
//  Created by Aparna Jain on 6/16/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "FiltersViewController.h"
#import "YelpClient.h"


@interface FiltersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL radiusExpanded;
@property (nonatomic, assign) BOOL sortTypeExpanded;
@property (nonatomic, assign) BOOL categoriesExpanded;
@property (nonatomic, strong) NSMutableDictionary *expanded;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, assign) NSInteger categoriesIntialRows;
@property (nonatomic, strong) YelpClient *client;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Filters";
        self.expanded = [NSMutableDictionary dictionary];
        self.params = [[NSMutableDictionary alloc] init];
        self.categories = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FiltersCell"];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButtonClick)];
    self.navigationItem.leftBarButtonItem = doneButton;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(onSearchButtonClick)];
    self.navigationItem.rightBarButtonItem = searchButton;
    self.client = [[YelpClient alloc] init];
    self.categoriesIntialRows = 5;

//    self.filters = [[Filters alloc] init]; //why did this make the variables lose their values

}
- (void)onDoneButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)onSearchButtonClick
{
    self.client.isSearchedFromFiltersPage = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma tableView methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.filters.sections count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2) {
        return [self.expanded[@(section)] boolValue] ? [self.filters.sections[section][@"rows"] count] : self.categoriesIntialRows;

    }else {
        return [self.expanded[@(section)] boolValue] ? [self.filters.sections[section][@"rows"] count] : 1;
    }

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiltersCell" forIndexPath:indexPath];
    NSArray *rows = self.filters.sections[indexPath.section][@"rows"];
    cell.textLabel.text = rows[indexPath.row];
    switch (indexPath.section) {
        case 0:
            if (self.expanded[@(indexPath.section)]) {
                cell.accessoryType = self.filters.radiusIndex == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            }else{
                cell.textLabel.text = self.filters.sections[0][@"rows"][self.filters.radiusIndex];
            }
            break;
        case 1:
            if (self.expanded[@(indexPath.section)]) {
                cell.accessoryType = self.filters.sortTypeIndex == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            }else{
                cell.textLabel.text = self.filters.sections[1][@"rows"][self.filters.sortTypeIndex];
            }
            break;
        case 2://for the categories
            if (!self.expanded[@(indexPath.section)] && self.categoriesIntialRows - 1== indexPath.row) {
                cell.textLabel.text = @"See All";
            }
            else{
                cell.textLabel.text = rows[indexPath.row];
            }
            cell.accessoryType = [self.filters.categories containsObject:@(indexPath.row)] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            break;
        case 3:
            cell.accessoryType = self.filters.dealOnly ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.expanded[@(indexPath.section)] = @(![self.expanded[@(indexPath.section)] boolValue]);
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    self.filters.parametersArray[@(indexPath.section)] = @(indexPath.row);
    switch (indexPath.section) {
        case 0:
            [[NSUserDefaults standardUserDefaults] setObject:@(indexPath.row) forKey:@"radius_filter"];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:@(indexPath.row) forKey:@"sort"];
            break;
        default:
            break;
    }
    
    if (indexPath.section == 2) { //categories
//        self.filters.parametersArray[@(indexPath.section)] = [[NSMutableArray alloc] init];
        if (!self.expanded[@(indexPath.section)] && self.categoriesIntialRows - 1== indexPath.row) {
           self.expanded[@(indexPath.section)] = @(YES);
        }
        else{
            if (cell.accessoryType == UITableViewCellAccessoryNone) {
                [self.filters.categories addObject:@(indexPath.row)];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                [self.filters.categories removeObject:@(indexPath.row)];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];

}
- (void)saveDictionary:(NSMutableDictionary *)dict key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:dict];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

- (NSMutableDictionary *)dictionaryFromUserDefaults:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return dict;
}

- (void)saveNumber:(NSNumber *)num key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:key];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

- (NSString *)stringFromUserDefaults:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSString *str = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return str;
}


@end
