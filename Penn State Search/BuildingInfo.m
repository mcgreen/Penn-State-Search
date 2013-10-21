//
//  BuildingInfo.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/16/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "BuildingInfo.h"

@interface BuildingInfo()
@property (nonatomic, strong) NSString *building;
@property (nonatomic, strong) NSNumber *opp_bldg_code;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) UIImage *buildingImage;
@end


@implementation BuildingInfo

-(id)initWithBuilding:(NSString*)building opp_bldg_code:(NSNumber*)opp_bldg_code photo:(NSString*)photo{
    self = [super init];
    if(self){
        _building = building;
        _opp_bldg_code = opp_bldg_code;
        _photo = photo;
        NSString *buildingPhoto = [NSString stringWithFormat:@"buildings/%@.jpg", photo];
        _buildingImage = [UIImage imageNamed:buildingPhoto];
    }
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder{
    self = [super init];
    if(self){
        _building = [aDecoder decodeObjectForKey:@"name"];
        _photo = [aDecoder decodeObjectForKey:@"photo"];
        _buildingImage = [aDecoder decodeObjectForKey:@"image"];
        _opp_bldg_code = [aDecoder decodeObjectForKey:@"opp_bldg_code"];
        
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_building forKey:@"name"];
    [aCoder encodeObject:_photo forKey:@"photo"];
    [aCoder encodeObject:_buildingImage forKey:@"image"];
    [aCoder encodeObject:_opp_bldg_code forKey:@"opp_bldg_code"];
}


@end
