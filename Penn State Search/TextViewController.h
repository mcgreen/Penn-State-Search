//
//  TextViewController.h
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/8/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@protocol searchResults <NSObject>
-(NSIndexPath*)clickedSelectedRowInformation;
@end

@interface TextViewController : UIViewController <UITableViewDelegate>
@property (nonatomic, strong) SearchModel *model;
@property (nonatomic, strong) id<searchResults> delegate;
@end
