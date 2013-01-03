//
//  TSTTableViewController.m
//  ClearStyle 5
//
//  Created by wangyongqi on 12/25/12.
//  Copyright (c) 2012 wyq. All rights reserved.
//

// commit changes 1

#import "TSTTableViewController.h"
#import "TSTToDoItem.h"
#import "TSTTableViewCell.h"

#define DEFAULT_CELLIDENTIFIER @"Cell"

@interface TSTTableViewController ()
{
    NSMutableArray *_toDoItems;
}

@end

@implementation TSTTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _toDoItems = [NSMutableArray array];
        NSArray *_items = @[@"Feed the cat",
            @"Buy eggs",
            @"Pack bags for WWDC",
            @"Rule the web",
            @"Buy a new iPhone",
            @"Find missing socks",
            @"Write a new tutorial",
            @"Master Objective-C",
            @"Remember your wedding anniversary!",
            @"Drink less beer",
            @"Learn to draw",
            @"Take the car to the garage",
            @"Sell things on eBay",
            @"Learn to juggle",
            @"Give u"];
        
        for (NSString *item in _items) {
            [_toDoItems addObject:[TSTToDoItem toDoItemWithText:item]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[TSTTableViewCell class] forCellReuseIdentifier:DEFAULT_CELLIDENTIFIER];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_toDoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DEFAULT_CELLIDENTIFIER];
    
    // Configure the cell...
    TSTToDoItem *item = _toDoItems[indexPath.row];
//    cell.textLabel.text = item.text;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.toDoItem = item;
    cell.delegate = self;
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexRow = indexPath.row;
    float green = (float)indexRow / (float)(_toDoItems.count - 1) * 0.6f;
    cell.backgroundColor = [UIColor colorWithRed:1.0f green:green blue:0.0f alpha:1.0f];
}

#pragma make - TSTTableViewCellDelegate

//-(void)deleteToDoItem:(TSTToDoItem *)toDoItem
//{
//    NSUInteger row = [_toDoItems indexOfObject:toDoItem];
//    
//    [self.tableView beginUpdates];
//    [_toDoItems removeObject:toDoItem];
//    NSArray *deletions = @[[NSIndexPath indexPathForRow:row inSection:0]];
//    [self.tableView deleteRowsAtIndexPaths:deletions withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView endUpdates];
//}

-(void)deleteToDoItem:(TSTToDoItem *)toDoItem
{
    NSArray *visibleCells = [self.tableView visibleCells];
    
    bool startAnimation = false;
    
    float delay = 0.0f;
    
    for (TSTTableViewCell *cell in visibleCells) {
        if (startAnimation) {
            [UIView animateWithDuration:0.3
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 cell.frame = CGRectOffset(cell.frame, 0, - cell.bounds.size.height);
                             }
                             completion:^(BOOL finished) {
                                 [self.tableView reloadData];
                             }];
            delay += 0.03;
        }
          
        if (cell.toDoItem == toDoItem) {
            startAnimation = YES;
            
        }
    }
    
}

//-(void)deleteToDoItem:(TSTToDoItem *)toDoItem
//{
//    float delay = 0.0;
//    
//    // remove the model object
//    [_toDoItems removeObject:toDoItem];
//    
//    // find the visible cells
//    NSArray* visibleCells = [self.tableView visibleCells];
//    
//    UIView* lastView = [visibleCells lastObject];
//    bool startAnimating = false;
//    
//    // iterate over all of the cells
//    for(TSTTableViewCell* cell in visibleCells)
//    {
//        if (startAnimating) {
//            [UIView animateWithDuration:0.3
//                                  delay:delay
//                                options:UIViewAnimationOptionCurveEaseInOut
//                             animations:^{
//                                 cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
//                             }
//                             completion:^(BOOL finished){
//                                 if (cell == lastView) {
//                                     [self.tableView reloadData];
//                                 }
//                             }];
//            delay+=0.05;
//        }
//        
//        // if you have reached the item that was deleted, start animating
//        if (cell.toDoItem == toDoItem) {
//            startAnimating = true;
//            cell.hidden = YES;
//        }
//    }
//}

@end
