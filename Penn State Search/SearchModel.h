//
//  SearchModel.h
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/2/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

+(id)sharedInstance;
-(NSString*)enteredFirstName;
-(NSString*)enteredLastName;
-(NSString*)enteredAccessID;

-(void)textFirstName:(UITextField*)textField;
-(void)textLastName:(UITextField*)textField;
-(void)textAccessID:(UITextField*)textField;

-(void)performSearchWithFirstName:firstName lastName:lastName andAccessID:AccessID;

-(NSInteger)count;
-(NSInteger)photoBuildingCount;
-(NSInteger)buildingCount;
-(NSArray*)searchInfoArray;
-(NSString*)nameAtIndex:(NSInteger)index;
-(NSString*)addressAtIndex:(NSInteger)index;

-(NSArray*)sortArray;

-(NSMutableArray*)buildingsArray;
-(void)populateBuildings;
-(void)populatePhotoBuildings;

-(NSString *)buildingNameAtIndex:(NSInteger)index;
-(NSString*)buildingOpAtIndex:(NSInteger)index;
-(NSString *)affiliationAtIndex:(NSInteger)index;
-(NSString *)majorAtIndex:(NSInteger)index;
-(NSString *)campusAtIndex:(NSInteger)index;
-(NSString *)mobileAtIndex:(NSInteger)index;
-(NSString *)emailAtIndex:(NSInteger)index;
-(NSString*)buildingPictureAtIndex:(NSInteger)index;
-(NSString*)buildingPhotoPictureAtIndex:(NSInteger)index;
-(NSString*)buildingPhotoOpAtIndex:(NSInteger)index;
-(NSString *)buildingPhotoNameAtIndex:(NSInteger)index;
@end
