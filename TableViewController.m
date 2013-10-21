//
//  TableViewController.m
//  Penn State Search
//
//  Created by MICHAEL COLE GREEN on 10/2/13.
//  Copyright (c) 2013 MICHAEL COLE GREEN. All rights reserved.
//

#import "TableViewController.h"
#import "SearchModel.h"
#import "TextViewController.h"
extern UIColor *  const COLOR_LIGHT_BLUE;
@interface TableViewController ()<searchResults>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model count];
}

-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Results";
}

-(NSIndexPath*)clickedSelectedRowInformation{
    
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    return index;
    
    
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    UIColor* const COLOR_LIGHT_BLUE = [[UIColor alloc] initWithRed:21.0f/255 green:180.0f/255  blue:1 alpha:1];
    static NSString *CellIdentifier = @"Cell";
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
    cell.textLabel.text = [self.model nameAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.model addressAtIndex:indexPath.row];
        
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchResults"]){
        TextViewController *textViewController = segue.destinationViewController;
        textViewController.model = self.model;
        textViewController.delegate = self;
        
    }
}


@end
