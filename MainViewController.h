//
//  MainViewController.h
//  feedME
//
//  Created by Aparna Jain on 6/12/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filters.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) Filters *filters;
- (void)fetchDataWithParam;
@end
