
//
//  SearchModel.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/2/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "SearchModel.h"
#import "RHLDAPSearch.h"
#import "BuildingInfo.h"
static NSString * const filename = @"buildings.archive";

@interface SearchModel()

@property (nonatomic, strong) NSArray *searchInfo;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *accessID;

@property (nonatomic, strong)RHLDAPSearch *searchDirectory;

@property (nonatomic, strong) NSMutableArray *buildingList;
@property (nonatomic, strong) NSMutableArray *buildingListArchive;
@property (nonatomic, strong) NSMutableArray *sortBuildingArray;
@property (nonatomic, strong) NSMutableArray *photoBuildingArray;

-(NSString*)enteredFirstName;
-(NSString*)enteredLastName;
-(NSString*)enteredAccessID;
-(NSArray*)searchInfoArray;



@end



@implementation SearchModel

+(id)sharedInstance{
    static id singleton = nil;
    if(!singleton){
        singleton = [[self alloc]init];
    }
    return singleton;
}

-(id) init{
    
    self = [super init];
    if(self){
        
        self.searchDirectory = [[RHLDAPSearch alloc] initWithURL:@"ldap://ldap.psu.edu:389"];
        self.photoBuildingArray = [[NSMutableArray alloc]init];
        
        if ([self fileExists]) {
            
            NSString *path = [self filePath];
            self.buildingList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            
            
        }
        else {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:@"buildings" ofType:@"plist"];
            
            self.buildingListArchive = [NSArray arrayWithContentsOfFile:path];
            
            NSArray *tmp = [self sortArray];
            self.buildingListArchive = [(NSArray*)tmp mutableCopy];
            
            [self.buildingListArchive writeToFile:[self filePath] atomically:YES];
                        
            _buildingList = [NSMutableArray array];
            
            for (NSDictionary *dict in self.buildingListArchive) {
                BuildingInfo *info = [[BuildingInfo alloc] initWithBuilding:dict[@"name"] opp_bldg_code:dict[@"opp_bldg_code"] photo:dict[@"photo"]];
                [_buildingList addObject:info];
            }
            
            [NSKeyedArchiver archiveRootObject:_buildingList toFile:[self filePath]];
            
        }
        
        
    }

        


    return self;
}

-(NSString*)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSString *)filePath {
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:filename];
}

-(BOOL)fileExists {
    NSString *path = [self filePath];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


-(void)textFirstName:(UITextField*)textField{
    self.firstName = textField.text;
}

-(void)textLastName:(UITextField*)textField{
    self.lastName = textField.text;
}

-(void)textAccessID:(UITextField*)textField{
    self.accessID = textField.text;
}


-(NSString*)enteredFirstName{
    return self.firstName;
}

-(NSString*)enteredLastName{
    return self.lastName;
}

-(NSString*)enteredAccessID{
    return self.enteredAccessID;
}

-(RHLDAPSearch*)searchObject{
    return self.searchDirectory;
}




-(NSMutableArray*)buildingsArray{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *buildingsFile = [mainBundle pathForResource:@"buildings" ofType:@".plist"];
    NSMutableArray *buildingList = [[NSMutableArray alloc] initWithContentsOfFile:buildingsFile];
    
    return buildingList;
}

-(NSInteger)buildingCount{
    return [self.buildingList count];
}
-(NSInteger)photoBuildingCount{
    return [self.photoBuildingArray count];
}



-(NSArray*)sortArray{
    
    NSSortDescriptor *buildingName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *identifier = [NSArray arrayWithObjects:buildingName, nil];
    NSArray *sortedBuildings = [self.buildingListArchive sortedArrayUsingDescriptors:identifier];
    
    return sortedBuildings;
    
}

-(void)populateBuildings{

    [self populatePhotoBuildings];
        
}

-(void)populatePhotoBuildings{
    
    for(int i = 0; i < [self.buildingList count]; i++){
        BuildingInfo *info = [self.buildingList objectAtIndex:i];
        NSString *photo = info.photo;
        
        if([photo length] != 0){
            
            [self.photoBuildingArray addObject:info];
        }
    }
    
}

-(void)performSearchWithFirstName:(NSString*)firstName lastName:(NSString*)lastName andAccessID:(NSString*)accessID{
    
    NSError *objectError = [[NSError alloc]init];
    NSString *searchQuery = [NSString stringWithFormat:@"(&"];
    
    if(firstName.length > 0){
        searchQuery = [searchQuery stringByAppendingString:[NSString stringWithFormat:@"(givenName=%@)", firstName]];
    }
    if(lastName.length > 0){
        searchQuery = [searchQuery stringByAppendingString:[NSString stringWithFormat:@"(sn=%@)", lastName]];
    }
    if(accessID.length > 0){
        searchQuery = [searchQuery stringByAppendingString:[NSString stringWithFormat:@"(uid=%@)", accessID]];
    }
    
    searchQuery = [searchQuery stringByAppendingString:@")"];
    self.searchInfo = [self.searchDirectory searchWithQuery:searchQuery withinBase:@"dc=psu,dc=edu" usingScope:RH_LDAP_SCOPE_SUBTREE error:&objectError];
    
    
}
-(NSInteger)count{
    return [self.searchInfo count];
}


-(NSArray*)searchInfoArray{
    return self.searchInfo;
    
}

-(NSString *)buildingNameAtIndex:(NSInteger)index{
    BuildingInfo *info = [self.buildingList objectAtIndex:index];
    NSString *name = info.building;
    return name;
}

-(NSString*)buildingOpAtIndex:(NSInteger)index{
    BuildingInfo *info = [self.buildingList objectAtIndex:index];
    NSNumber *oppCode = info.opp_bldg_code;
    NSString *buildingOPP = [NSString stringWithFormat:@"%@", oppCode];
    return buildingOPP;
    
}

-(NSString*)buildingPictureAtIndex:(NSInteger)index{
    BuildingInfo *info = [self.buildingList objectAtIndex:index];
    NSString *photo = info.photo;
    return photo;
}




-(NSString *)buildingPhotoNameAtIndex:(NSInteger)index{
    BuildingInfo *info = [self.photoBuildingArray objectAtIndex:index];
    NSString *photoName = info.building;
    return photoName;
}

-(NSString*)buildingPhotoOpAtIndex:(NSInteger)index{
    BuildingInfo *info = [self.photoBuildingArray objectAtIndex:index];
    NSNumber *oppCode = info.opp_bldg_code;
    NSString *buildingOPP = [NSString stringWithFormat:@"%@", oppCode];
    return buildingOPP;
}

-(NSString*)buildingPhotoPictureAtIndex:(NSInteger)index{
    BuildingInfo *info = [self.photoBuildingArray objectAtIndex:index];
    NSString *photoPicture = info.photo;
    return photoPicture;
    
}




-(NSString *)nameAtIndex:(NSInteger)index{
    NSDictionary *dictionary = [self.searchInfo objectAtIndex:index];
    NSString *name = [dictionary objectForKey:@"cn"][0];
    return name;
}

-(NSString*)addressAtIndex:(NSInteger)index{
    NSDictionary *dictionary = [self.searchInfo objectAtIndex:index];
    NSString *address = [dictionary objectForKey:@"postalAddress"][0];
    NSArray *addressArray = [address componentsSeparatedByString:@"$"];
    return [addressArray componentsJoinedByString:@"\n"];
}

-(NSString *)emailAtIndex:(NSInteger)index{
    NSDictionary *dictionary = [self.searchInfo objectAtIndex:index];
    NSString *email = [dictionary objectForKey:@"mail"][0];
    return email;
}

-(NSString *)mobileAtIndex:(NSInteger)index{
    NSDictionary *dictionary = [self.searchInfo objectAtIndex:index];
    NSString *mobile = [dictionary objectForKey:@"mobile"][0];
    return mobile;
}
-(NSString *)campusAtIndex:(NSInteger)index{
    NSDictionary *dictionary = [self.searchInfo objectAtIndex:index];
    NSString *campus = [dictionary objectForKey:@"psCampus"][0];
    return campus;
}

-(NSString *)majorAtIndex:(NSInteger)index{
    NSDictionary *dictionary = [self.searchInfo objectAtIndex:index];
    NSString *major = [dictionary objectForKey:@"psCurriculum"][0];
    return major;
}
-(NSString *)affiliationAtIndex:(NSInteger)index{
    NSDictionary *dictionary = [self.searchInfo objectAtIndex:index];
    NSString *affiliation = [dictionary objectForKey:@"eduPersonPrimaryAffiliation"][0];
    return affiliation;
}
@end

