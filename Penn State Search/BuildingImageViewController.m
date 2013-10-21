//
//  BuildingImageViewController.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/10/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "BuildingImageViewController.h"
#import "SearchModel.h"
#import "Constants.h"
#define kMaxZoomScale 2.0
#define KMinZoomScale 0.5

@interface BuildingImageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic, assign) BOOL toggleSwitch;
@property (nonatomic, assign) BOOL toggleSwitchZoom;
@end

@implementation BuildingImageViewController

-(id)initWithCoder:(NSCoder*)aDecoder{
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:kShowPhotoBuildings];
    NSNumber *boolNumberZoom = [preferences objectForKey:kAllowZoom];
    self.toggleSwitch = [boolNumber boolValue];
    self.toggleSwitchZoom = [boolNumberZoom boolValue];
    
	NSIndexPath *index = [self.delegate clickedSelectedBuildingInformation];
    NSInteger row = index.row;
    NSString *photo;
    
    
    if(self.toggleSwitch){
        photo = [self.model buildingPhotoPictureAtIndex:row];
        self.navigationItem.title = [self.model buildingPhotoNameAtIndex:index.row];
    }
    else{
        photo = [self.model buildingPictureAtIndex:row];
        self.navigationItem.title = [self.model buildingNameAtIndex:index.row];
    }
    
    
    photo = [photo stringByAppendingString:@".jpg"];
    UIImage *image = [UIImage imageNamed:photo];
    _imageView = [[UIImageView alloc]initWithImage:image];
        
    
    [self.photoScrollView addSubview:self.imageView];
    
    self.photoScrollView.contentSize = image.size;
    self.photoScrollView.minimumZoomScale = self.view.bounds.size.width / image.size.width;
    if(self.toggleSwitchZoom){
        self.photoScrollView.maximumZoomScale = kMaxZoomScale;
    }
    else{
        self.photoScrollView.maximumZoomScale = self.view.bounds.size.width / image.size.width;
    }
    
    
    
    
    self.photoScrollView.bounces = YES;
    self.photoScrollView.delegate = self;
    [self.photoScrollView zoomToRect:self.imageView.bounds animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
