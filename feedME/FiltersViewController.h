//
//  FiltersViewController.h
//  feedME
//
//  Created by Aparna Jain on 6/16/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filters.h"

@interface FiltersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Filters *filters;
@end
