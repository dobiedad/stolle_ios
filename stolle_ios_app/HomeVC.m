#import "HomeVC.h"
#import "Reachability.h"
#import "SCLAlertView.h"

@interface HomeVC ()

@end

@implementation HomeVC
@synthesize stolleWebView;
@synthesize loadingView;
@synthesize superView;
- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor grayColor]];
    stolleWebView.scrollView.showsVerticalScrollIndicator = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)setupWebView {
    loadingView.hidden=false;
    [self reachability];
    [self requestStolleUrl];
    self.stolleWebView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
}



- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#tabs').addClass('hidden')"];
    [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#header').addClass('hidden')"];
    [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#reviews').addClass('hidden')"];
    [stolleWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [stolleWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self loadedContent];



}
-(void)loadedContent{
    [UIView transitionWithView:loadingView
                      duration:.25
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:^(BOOL finished) {
                        loadingView.hidden=true;
                    }];
    

}
- (void)requestStolleUrl {
    NSString *stolleURL = @"http://localhost:3000/codes/ae38b5";
    NSURL *url = [NSURL URLWithString:stolleURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [stolleWebView loadRequest:requestObj];
    stolleWebView.scrollView.bounces = NO;
    stolleWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [stolleWebView setNeedsDisplay];

}
- (IBAction)logoClicked:(id)sender {
    [self requestStolleUrl];

}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if([item.title isEqualToString:@"Home"]) {
    [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#home-button').click();"];
    }
    if([item.title isEqualToString:@"Menu"]) {
        [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#menu-button').click();"];
    }
    if([item.title isEqualToString:@"Bookings"]) {
        [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('.r-menu').click();"];
    }
    if([item.title isEqualToString:@"Contact"]) {
        [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#contact-button').click();"];
    }
   
}
- (void)reachability {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    reach.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"REACHABLE!");
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"No internet");
        dispatch_sync(dispatch_get_main_queue(), ^{
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            
            [alert showWarning:@"Stolle" subTitle:@"This app requires an internet connection, please try again." closeButtonTitle:@"Done" duration:0.0f];        });
       
    };
    
    [reach startNotifier];
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    [self setupWebView];
}

- (void)appWillEnterForeground:(NSNotification *)notification {
//    NSLog(@"will enter foreground notification");
}


@end
