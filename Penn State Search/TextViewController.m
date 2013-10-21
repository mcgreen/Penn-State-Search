//
//  TextViewController.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/8/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "TextViewController.h"
#import "SearchModel.h"

@interface TextViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *mailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *psCampusLabel;
@property (weak, nonatomic) IBOutlet UILabel *psCurriculumLabel;
@property (weak, nonatomic) IBOutlet UILabel *affiliationLabel;
@property (weak, nonatomic) NSIndexPath *selectedRow;

@end

@implementation TextViewController



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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedRow = [self.delegate clickedSelectedRowInformation];
    NSInteger row = self.selectedRow.row;
    [self fillLabelsWithDetailedInformation:row];
  
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fillLabelsWithDetailedInformation:(NSInteger)index{
    self.displayName.text = [self.model nameAtIndex:index];
    self.mailLabel.text = [self.model emailAtIndex:index];
    self.mobileLabel.text = [self.model mobileAtIndex:index];
    self.psCampusLabel.text = [self.model campusAtIndex:index];
    self.psCurriculumLabel.text = [self.model majorAtIndex:index];
    self.affiliationLabel.text = [self.model affiliationAtIndex:index];
    
}

@end
