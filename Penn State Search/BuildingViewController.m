//
//  BuildingViewController.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/7/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "BuildingViewController.h"
#import "SearchModel.h"
#import "BuildingImageViewController.h"
#import "Constants.h"
#import "PreferencesViewController.h"

extern UIColor *  const COLOR_LIGHT_BLUE;
@interface BuildingViewController ()<searchResults>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *imageName;
@property (nonatomic, assign) BOOL toggleBuildingPhotos;

@end

@implementation BuildingViewController


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        _model = [[SearchModel alloc] init];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageName = @"";
    
    
    [self.model populateBuildings];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self){
        
        [[[self tabBarController] navigationItem] setTitle:@"Buildings Search"];
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        NSNumber *boolNumber = [preferences objectForKey:kShowPhotoBuildings];
        self.toggleBuildingPhotos = [boolNumber boolValue];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
   
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.toggleBuildingPhotos == NO){
        return [self.model buildingCount];
    }
    else{
        return [self.model photoBuildingCount];
    }
    
}

-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Buildings List";
}


-(NSIndexPath*)clickedSelectedBuildingInformation{
    
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    return index;
        
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    UIColor* const COLOR_LIGHT_BLUE = [[UIColor alloc] initWithRed:21.0f/255 green:180.0f/255  blue:1 alpha:1];
    static NSString *CellIdentifier = @"BuildingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    tableView.backgroundView = nil;
    tableView.backgroundView = [[UIView alloc] init];
    tableView.separatorColor = [UIColor whiteColor];
    tableView.backgroundColor = COLOR_LIGHT_BLUE;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    if(self.toggleBuildingPhotos == NO){
        cell.textLabel.text = [self.model buildingNameAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.model buildingOpAtIndex:indexPath.row];
        self.imageName = [self.model buildingPictureAtIndex:indexPath.row];
        
        
        if([self.imageName length] == 0){
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.userInteractionEnabled = NO;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
       
    }
    }
    else if(self.toggleBuildingPhotos == YES){
        cell.textLabel.text = [self.model buildingPhotoNameAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.model buildingPhotoOpAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled = YES;
    }
      
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchResults"]){
        BuildingImageViewController *imageViewController = segue.destinationViewController;
        imageViewController.model = self.model;
        imageViewController.delegate = self;
        
    }
    else if([segue.identifier isEqualToString:@"searchProperty"]){
        PreferencesViewController *preferencesViewController = segue.destinationViewController;
        preferencesViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
        
    }
}



@end
