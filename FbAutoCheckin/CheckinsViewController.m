//
//  CheckinsViewController.m
//  FbAutoCheckin
//
//  Created by Han Ma on 18/03/12.
//  Copyright (c) 2012 hasnotes. All rights reserved.
//

#import "CheckinsViewController.h"
#import "FacebookManager.h"
#import "Place.h"

@interface CheckinsViewController ()

@end

@implementation CheckinsViewController

@synthesize Checkins = _Checkins;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
                
    }
    return self;
}

-(void)setCheckins:(NSArray *)Checkins
{
    _Checkins = Checkins;
    [self.tableView reloadData];
}

-(NSArray*)Checkins
{
    return _Checkins;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)processCheckinData:(NSArray*) checkins
{
    NSMutableArray *places = [[NSMutableArray alloc]init];
    for (NSDictionary* checkin in checkins)
    {
        Place* place = [[Place alloc]init];
        place.PlaceID = [[checkin objectForKey:@"place"] objectForKey:@"id"];
        place.PlaceName = [[checkin objectForKey:@"place"]objectForKey:@"name"];
        place.CheckedMessage = [checkin objectForKey:@"message"]?[checkin objectForKey:@"message"]:@"";
        
        [places addObject:place];
    }

    self.Checkins = places;
}
- (IBAction)refresh:(id)sender 
{
    [self loadCheckins];
}

- (void)loadCheckins
{
    [[FacebookManager defaultManager] loadChekinsWithCompletionHandler:^(NSArray* result)
     {
         [self processCheckinData:result];
     }
                                                       andErrorHandler:^(NSError *error)
     {
         
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [[FacebookManager defaultManager] addObserver:self forKeyPath:@"loggedin" options:NSKeyValueObservingOptionNew context:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    [self loadCheckins];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.Checkins count]);
    return [self.Checkins count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    Place* place = [self.Checkins objectAtIndex:indexPath.row];
    
    cell.textLabel.text = place.PlaceName;
    cell.detailTextLabel.text = place.CheckedMessage;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
