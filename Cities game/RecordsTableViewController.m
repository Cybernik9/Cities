//
//  RecordsTableViewController.m
//  Cities game
//
//  Created by Admin on 26.12.15.
//  Copyright © 2015 HY. All rights reserved.
//

#import "RecordsTableViewController.h"

@interface RecordsTableViewController ()

@property (strong, nonatomic) NSArray* nameArray;

@end

@implementation RecordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.nameArray = [[NSMutableArray alloc] initWithArray:
                      [defaults objectForKey:@"player"]];

    NSSortDescriptor *sortByName = [NSSortDescriptor
                                    sortDescriptorWithKey:@"count"
                                    ascending:NO];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    self.nameArray = [self.nameArray sortedArrayUsingDescriptors:sortDescriptors];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    NSDictionary *dictionary = [self.nameArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dictionary valueForKey:@"name"];
    cell.detailTextLabel.text = [dictionary valueForKey:@"count"];
    
    if (indexPath.row >= 0 && indexPath.row < 3) {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    else if (indexPath.row >= 3 && indexPath.row < 6) {
        cell.detailTextLabel.textColor = [UIColor yellowColor];
    }
    else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}

@end
