//
//  MenuViewController.h
//  stolle_ios_app
//
//  Created by Leo on 25/01/2015.
//  Copyright (c) 2015 Featurist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end
