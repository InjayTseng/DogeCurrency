//
//  ViewController.m
//  DogeCurrency
//
//  Created by David Tseng on 1/22/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "AutoCoding+RecursiveParsing.h"
#import "AddressToCoordinate.h"
@interface ViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSString *webPageString = @"http://doge.yottabyte.nu/";
//    NSURL *webPageStringURL = [NSURL URLWithString:webPageString];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:webPageStringURL];
//    [self.webView setDelegate:self];
//    [self.webView loadRequest:requestObj];
    
    [self forCountzDown];
}


-(void)forCountzDown{


    NSArray *tutorialsNodes = [self nodesParsedWithUrl:@"http://www.319papago.idv.tw/lifeinfo/family-ice/family-ice-02.html" andQueryString:@"//tr/td"];
//    NSMutableArray * titleArray = [[NSMutableArray alloc] initWithCapacity:0];
//    NSMutableArray *hrefArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    for (int i=0;i<tutorialsNodes.count;i++) {
        TFHppleElement *element = [tutorialsNodes objectAtIndex:i];
        NSLog(@"%@",[element text]);
        
        if ((i+1)%3 == 0) {
            
            //if (tutorialsNodes.count - i < 40) {
                CLLocationCoordinate2D loc = [AddressToCoordinate locationFromAddress:[element text]];
                NSLog(@"(%f,%f)",loc.latitude,loc.longitude);
            //}

        }

        
    }
    
    
    
}

-(void)makeJson{

}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
        // UIWebView object has fully loaded.
    }
    
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                      @"document.documentElement.outerHTML"];
    
    NSArray *tutorialsNodes = [self nodesParsedWithHTML:html andQueryString:@"//div/div"];
    
    for (TFHppleElement *element in tutorialsNodes) {
        //NSLog(@"%@ %@",element.tagName, [element objectForKey:@"bid"]);
        NSLog(@"----------------\nTag:%@\nText:%@\nContent:%@\natt:%@\nRaw:%@\n",[element tagName],[element text],[element content],[element attributes],[element raw]);
//        for (TFHppleElement *child in element.children) {
//            if ([child.tagName isEqualToString:@"span"]) {
//                
//                NSLog(@"*****************\nTag:%@\nText:%@\nContent:%@\natt:%@\nRaw:%@\n",[element tagName],[element text],[element content],[element attributes],[element raw]);
//                
//                for (TFHppleElement *childchild in child.children) {
//                    
//                    NSLog(@"childchild %@:%@ %@ %@\n--",[childchild tagName],[childchild text],[childchild content],[childchild attributes]);
//                    
//                }
//            }
//        }
    }
    
    [self performSelector:@selector(reload) withObject:nil afterDelay:3];
}

-(void)reload{
    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:
                      @"document.documentElement.outerHTML"];
    
    NSArray *tutorialsNodes = [self nodesParsedWithHTML:html andQueryString:@"//div/div/span"];
    
    for (TFHppleElement *element in tutorialsNodes) {

//        NSLog(@"----------------\nTag:%@\nText:%@\nContent:%@\natt:%@\nRaw:%@\n",[element tagName],[element text],[element content],[element attributes],[element raw]);
//        for (TFHppleElement *child in element.children) {
//            if ([child.tagName isEqualToString:@"span"]) {
//                
//                NSLog(@"*****************\nTag:%@\nText:%@\nContent:%@\natt:%@\nRaw:%@\n",[element tagName],[element text],[element content],[element attributes],[element raw]);
//                
//                for (TFHppleElement *childchild in child.children) {
//                    
//                    NSLog(@"childchild %@:%@ %@ %@\n--",[childchild tagName],[childchild text],[childchild content],[childchild attributes]);
//                    
//                }
//            }
//        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- basics

- (NSArray*)nodesParsedWithUrl:(NSString*)url andQueryString:(NSString*)queryString{
    
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:url];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3//<table class="views-view-grid">
    NSString *tutorialsXpathQueryString = queryString;
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    return tutorialsNodes;
}


- (NSArray*)nodesParsedWithHTML:(NSString*)html andQueryString:(NSString*)queryString{
    
    NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:data];
    
    // 3//<table class="views-view-grid">
    NSString *tutorialsXpathQueryString = queryString;
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    return tutorialsNodes;
}



@end
