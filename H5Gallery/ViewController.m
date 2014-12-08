//
//  ViewController.m
//  H5Gallery
//
//  Created by Gideon on 12/7/14.
//  Copyright (c) 2014 GQ. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *htmlContent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath =[array[0] stringByAppendingPathComponent:@"webapp/gallery.html"];
      NSString *webappPath = [resourcePath stringByAppendingPathComponent:@"webapp.zip"];
    NSString *destDir = [array[0] stringByAppendingPathComponent:@"webapp.zip"];
    NSString *newWebappDir = [array[0] stringByAppendingPathComponent:@"webapp"];
    if (access([webappPath UTF8String], 0) == 0) {
        BOOL flag = [fileManager copyItemAtPath:webappPath toPath:destDir error:nil];
        if (flag) {
            // 解压
            if (access([destDir UTF8String], 0) == 0) {
                BOOL unzipRet = unZipFile(destDir, newWebappDir,YES);
                if (unzipRet) {
                    remove([destDir UTF8String]);
                }
            }
            self.htmlContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            NSURL *baseURL =[NSURL fileURLWithPath:newWebappDir isDirectory:YES];
            [self.webView loadHTMLString:self.htmlContent baseURL:baseURL];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
//- (void)webViewDidStartLoad:(UIWebView *)webView;
//- (void)webViewDidFinishLoad:(UIWebView *)webView;
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
@end
