//
//  PreferencesViewController.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/15/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "PreferencesViewController.h"
#import "Constants.h"

@interface PreferencesViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *toggleBuildingPictures;
@property (weak, nonatomic) IBOutlet UISwitch *toggleBuildingZoom;

- (IBAction)dismissMe:(id)sender;

@end

@implementation PreferencesViewController

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
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolPhoto = [preferences objectForKey:kShowPhotoBuildings];
    NSNumber *boolZoom = [preferences objectForKey:kAllowZoom];
    self.toggleBuildingPictures.on = [boolPhoto boolValue];
    self.toggleBuildingZoom.on = [boolZoom boolValue];
       
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissMe:(id)sender {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:self.toggleBuildingPictures.isOn forKey:kShowPhotoBuildings];
    [preferences setBool:self.toggleBuildingZoom.isOn forKey:kAllowZoom];
    [preferences synchronize];
    
    self.CompletionBlock();
}
@end
