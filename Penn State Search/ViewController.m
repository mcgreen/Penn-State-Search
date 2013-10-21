//
//  ViewController.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 9/30/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "SearchModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *psuScrollView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *accessIDTextField;
- (IBAction)searchButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchButtonOutlet;
@property (nonatomic, strong) SearchModel *model;
@end


@implementation ViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        _model = [[SearchModel alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
        
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    if(self){
        [[[self tabBarController] navigationItem] setTitle:@"PSU Search"];
        self.firstNameTextField.text = @"";
        self.lastNameTextField.text = @"";
        self.accessIDTextField.text = @"";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(id)sender {
    
    [self.model performSearchWithFirstName:self.firstNameTextField.text lastName:self.lastNameTextField.text andAccessID:self.accessIDTextField.text];
           
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchResults"]){
        
        TableViewController *infoViewController = segue.destinationViewController;
        TableViewController *buildingViewController = segue.destinationViewController;
       
        buildingViewController.model = self.model;
        infoViewController.model = self.model;
    }
}

-(IBAction)unwindSegue:(UIStoryboardSegue *)segue {
        
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if(self.lastNameTextField.text.length == 0 && self.accessIDTextField.text.length == 0){
        return NO;
    }
    else{
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    
    NSInteger textFieldTag = textField.tag;
    
    [textField resignFirstResponder];
    
    if(textFieldTag == 2){
        [_psuScrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
      
    }
    return YES;
    
}



-(void)textFieldDidBeginEditing:(UITextField*)textField{
    
    NSInteger textFieldTag = textField.tag;
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 0.0, 216.0, 0.0);
    self.psuScrollView.contentInset = insets;
    if(textFieldTag == 2){
        [_psuScrollView setContentOffset:CGPointMake(0.0, _psuScrollView.frame.size.height/2) animated:YES];
    }
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    
    NSInteger textFieldTag = textField.tag;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    self.psuScrollView.contentInset = insets;
    
    if(textFieldTag == 0){
        [self.model textFirstName:textField];
    }
    else if(textFieldTag == 1){
        [self.model textLastName:textField];
    }
    else if(textFieldTag == 2){
        [self.model textAccessID:textField];
    }
       
    
}


@end
