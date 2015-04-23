//
//  MenuViewController.m
//  stolle_ios_app
//
//  Created by Leo on 25/01/2015.
//  Copyright (c) 2015 Featurist. All rights reserved.
//

#import "MenuViewController.h"
#import "AFNetworking.h"
static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";


@interface MenuViewController ()
{
    NSMutableArray *myObject;
    // A dictionary object
    NSDictionary *dictionary;
    // Define keys
    NSString *menu;
    NSString *item;
    NSString *cost;
}
@end

@implementation MenuViewController
@synthesize menuTableView;


-(void)getJson{
    menu = @"menu";
    item = @"item";
    cost = @"cost";
    
    myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"https://raw.githubusercontent.com/leomdivani/ribs/master/menu.json"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
//    NSArray *items = [jsonObjects objectForKey:@"items"];
//    NSDictionary *firstResult = [items objectAtIndex:0];
//    NSArray *disheNames = [firstResult objectForKey:@"name"];
//    
//    NSDictionary *dish = [disheNames objectAtIndex:0];
//

    
    
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSDictionary *item_data = [jsonObjects objectAtIndex:0];
        NSArray *menu_data = [dataDict objectForKey:@"items"];
        NSDictionary *item = [menu_data objectAtIndex:0];
        NSString *name = [item objectForKey:@"name"];
        NSString *img = [item objectForKey:@"img"];
        NSNumber *price = [item objectForKey:@"cost"];

        for(NSString *key in [dataDict allKeys]) {
            NSLog(@"%@",[dataDict objectForKey:key]);
        }
        NSLog(@"Menu: %@",menu_data);
        NSLog(@"Dish Name: %@",name);
        NSLog(@"Img URL: %@",img);
        NSLog(@"Price: %@",price);
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      menu_data, name,
                      img, price,
                      nil];
        [myObject addObject:dictionary];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *name;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    name = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKey:name]];
    
    NSMutableString *menuImg;
    menuImg = [NSMutableString stringWithFormat:@"Cost: %@ ",
              [tmpDict objectForKey:menuImg]];
    
    NSMutableString *menu_data;
    menu_data = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:menu_data]];
    
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:item]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text= menu_data;
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    cell.imageView.image =menuImg;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myObject.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getJson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
