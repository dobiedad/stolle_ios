
#import "HomeVC.h"
#import "Reachability.h"


@interface HomeVC ()

@end

@implementation HomeVC
@synthesize stolleWebView;
@synthesize loadingView;
@synthesize superView;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self reachability];
    [self requestStolleUrl];
    self.stolleWebView.delegate = self;
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor grayColor]];
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
    NSString *stolleURL = @"http://www.stolle.xyz/?app";
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
    NSLog(item.title);
    if([item.title isEqualToString:@"Home"]) {
    [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#home-button').click();"];
    }
    if([item.title isEqualToString:@"Menu"]) {
        [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#menu-button').click();"];
    }
    if([item.title isEqualToString:@"Bookings"]) {
        [stolleWebView stringByEvaluatingJavaScriptFromString:@"$('#booking-button').click();"];
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
            NSLog(@"REACHABLE!");
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Stolle" message:@"This app requires an internet connection, please connect to the internet." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    };
    
    [reach startNotifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
