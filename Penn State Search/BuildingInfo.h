//
//  BuildingInfo.h
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/16/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingInfo : NSObject <NSCoding>
-(id)initWithBuilding:(NSString*)building opp_bldg_code:(NSNumber*)opp_bldg_code photo:(NSString*)photo;
@property (nonatomic, readonly, strong) NSString *building;
@property (nonatomic, readonly, strong) NSNumber *opp_bldg_code;
@property (nonatomic, readonly, strong) NSString *photo;
@property (nonatomic, readonly, strong) UIImage *buildingImage;
@end
