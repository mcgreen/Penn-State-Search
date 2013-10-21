//
//  BuildingViewController.h
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/7/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface BuildingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) SearchModel *model;

@end
