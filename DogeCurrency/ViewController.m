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

    for (int i=0;i<25;i++){
        
        [self for711ice:i];
    
    }
    
    
//    for (int i=0;i<25;i++){
//    
//        [self forfamilyice:i];
//    }

}


-(void)for711ice:(int)number{


    NSString* url = [NSString stringWithFormat:@"http://www.319papago.idv.tw/lifeinfo/711icecream/711icecream-%02d.html",number];
    
    NSArray *tutorialsNodes = [self nodesParsedWithUrl:url andQueryString:@"//tr/td"];
    //    NSMutableArray * titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    //    NSMutableArray *hrefArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    NSMutableArray* siteArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic;
    
    int diff = 1;
    for (int i=0;i<tutorialsNodes.count;i++) {
        TFHppleElement *element = [tutorialsNodes objectAtIndex:i];
        
        if ([element text] == nil || i<8) {
            continue;
        }
        
        if ((i+diff)%3 == 0){
            
            
            dic = [[NSMutableDictionary alloc]init];
            NSLog(@"name:%@",[element text]);
            [dic setObject:[element text] forKey:@"name"];
            
        }else if ((i+diff)%3 == 1) { // 地址
            
            
            NSLog(@"phone:%@",[element text]);
            [dic setObject:[element text] forKey:@"phone"];
            
        }else if ((i+diff)%3 == 2){
            
            
            NSLog(@"address: %@",[element text]);
            [dic setObject:[element text] forKey:@"address"];
            CLLocationCoordinate2D loc = [AddressToCoordinate locationFromAddress:[element text]];
            if (loc.longitude == 0. && loc.longitude == 0.) {
                NSLog(@"Second Try");
                sleep(2);
                
                loc = [AddressToCoordinate locationFromAddress:[element text]];
                if (loc.longitude == 0. && loc.longitude == 0.) {
                    NSLog(@"Third Try");
                    sleep(3);
                    
                    loc = [AddressToCoordinate locationFromAddress:[element text]];
                    if (loc.longitude == 0. && loc.longitude == 0.) {
                        NSLog(@"Failed");
                    }
                }
                
            }
            
            
            [dic setObject:[NSString stringWithFormat:@"%f",loc.latitude] forKey:@"lat"];
            [dic setObject:[NSString stringWithFormat:@"%f",loc.longitude] forKey:@"lng"];
            NSLog(@"\nlat:%f\nlng:%f",loc.latitude,loc.longitude);
            
            
            
            
            NSLog(@"=============");
            if (dic) {
                [siteArray addObject:dic];
            }
            
            
        }
    }
    
    
    
    
    NSString * string = [siteArray bv_jsonStringWithPrettyPrint:YES];
    NSString * fileName = [NSString stringWithFormat:@"711-icecream-%02d.txt",number];
    
    [self writeStringToFile:string withFileName:fileName];
    

    
    
}

-(void)forfamilyice:(int)number{


    NSString* url = [NSString stringWithFormat:@"http://www.319papago.idv.tw/lifeinfo/family-ice/family-ice-%02d.html",number];
    
    NSArray *tutorialsNodes = [self nodesParsedWithUrl:url andQueryString:@"//tr/td"];
//    NSMutableArray * titleArray = [[NSMutableArray alloc] initWithCapacity:0];
//    NSMutableArray *hrefArray = [[NSMutableArray alloc]initWithCapacity:0];
    

    NSMutableArray* siteArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic;
    
    int diff = 0;
    for (int i=0;i<tutorialsNodes.count;i++) {
        TFHppleElement *element = [tutorialsNodes objectAtIndex:i];
        
        if ([element text] == nil || i==0 || i ==1) {
            continue;
        }
        
        if ((i+diff)%3 == 0){
            
            
            dic = [[NSMutableDictionary alloc]init];
            NSLog(@"name:%@",[element text]);
            [dic setObject:[element text] forKey:@"name"];
            
        }else if ((i+diff)%3 == 1) { // 地址
            
            
            NSLog(@"phone:%@",[element text]);
            [dic setObject:[element text] forKey:@"phone"];

        }else if ((i+diff)%3 == 2){
            
            
            NSLog(@"address: %@",[element text]);
            [dic setObject:[element text] forKey:@"address"];
            CLLocationCoordinate2D loc = [AddressToCoordinate locationFromAddress:[element text]];
            if (loc.longitude == 0. && loc.longitude == 0.) {
                NSLog(@"Second Try");
                sleep(2);
                
                loc = [AddressToCoordinate locationFromAddress:[element text]];
                if (loc.longitude == 0. && loc.longitude == 0.) {
                    NSLog(@"Third Try");
                    sleep(3);
                    
                    loc = [AddressToCoordinate locationFromAddress:[element text]];
                    if (loc.longitude == 0. && loc.longitude == 0.) {
                        NSLog(@"Failed");
                    }
                }
                
            }
            
            
            [dic setObject:[NSString stringWithFormat:@"%f",loc.latitude] forKey:@"lat"];
            [dic setObject:[NSString stringWithFormat:@"%f",loc.longitude] forKey:@"lng"];
            NSLog(@"\nlat:%f\nlng:%f",loc.latitude,loc.longitude);
            
            
            
            
            NSLog(@"=============");
            if (dic) {
                [siteArray addObject:dic];
            }
            

        }
    }
    

    
    
    NSString * string = [siteArray bv_jsonStringWithPrettyPrint:YES];
    NSString * fileName = [NSString stringWithFormat:@"family-ice-%02d.txt",number];
    
    [self writeStringToFile:string withFileName:fileName];
    
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

- (void)writeStringToFile:(NSString*)aString withFileName:(NSString*)fileName {
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = @"myTextFile.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    NSLog(@"Save at %@",fileAtPath);
    // The main act...
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}




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
