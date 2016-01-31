//
//  ViewController.h
//  stolle_ios_app
//
//  Created by Leo Mdivani on 01/12/2014.
//  Copyright (c) 2014 Featurist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController <UITabBarDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *stolleWebView;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) IBOutlet UIView *superView;

@property (weak, nonatomic) IBOutlet UIButton *logo;

@end

