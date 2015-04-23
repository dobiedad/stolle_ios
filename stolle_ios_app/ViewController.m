
#import "ViewController.h"
#import "Reachability.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize Stolle;
@synthesize loadingView;
@synthesize superView;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self reachability];
    [self requestStolleUrl];
    self.Stolle.delegate = self;
    [Stolle setHidden:true];
    
}





- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [labelLoading setHidden:NO];
//    loadingImage.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [labelLoading setHidden:YES];
//    loadingImage.hidden = YES;
    [Stolle stringByEvaluatingJavaScriptFromString:@"$('#tabs').addClass('hidden')"];
    [Stolle stringByEvaluatingJavaScriptFromString:@"$('#header').addClass('hidden')"];
    [self loadedContent];

}
-(void)loadedContent{
    [UIView transitionWithView:Stolle
                      duration:.25
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:NULL
                    completion:^(BOOL finished) {
                        Stolle.hidden=false;
                    }];
    

}
- (void)requestStolleUrl {
    NSString *stolleURL = @"http://localhost:3000/?app";
    NSURL *url = [NSURL URLWithString:stolleURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [Stolle loadRequest:requestObj];
    Stolle.scrollView.bounces = NO;
    Stolle.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [Stolle setNeedsDisplay];

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
    [Stolle stringByEvaluatingJavaScriptFromString:@"$('#home-button').click();"];
    }
    if([item.title isEqualToString:@"Menu"]) {
        [Stolle stringByEvaluatingJavaScriptFromString:@"$('#menu-button').click();"];
    }
    if([item.title isEqualToString:@"Reviews"]) {
        [Stolle stringByEvaluatingJavaScriptFromString:@"$('#reviews-button').click();"];
    }
    if([item.title isEqualToString:@"Bookings"]) {
        [Stolle stringByEvaluatingJavaScriptFromString:@"$('#booking-button').click();"];
    }
    if([item.title isEqualToString:@"Contact"]) {
        [Stolle stringByEvaluatingJavaScriptFromString:@"$('#contact-button').click();"];
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
