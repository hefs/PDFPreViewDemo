//
//  ViewController.m
//  PDFPreViewDemo
//
//  Created by 何发松 on 2017/6/22.
//  Copyright © 2017年 HeRay. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>
#import "PDFReaderViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource,UIDocumentInteractionControllerDelegate>{
    NSURL *pdfURL;
    
}
@property (nonatomic,copy) NSMutableData *pdfDatas;
@property (nonatomic,readwrite) QLPreviewController *previewCtrs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _pdfDatas = [[NSMutableData alloc] initWithCapacity:0];
}
- (IBAction)didVerifyTouchID:(id)sender {
    LAContext *context = [[LAContext alloc] init];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"姿势不对，换个姿势吧" reply:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
        if (error.code == -7) {
            UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:@"prefs:root=General"];
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }];
            UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warming" message:@"No fingers are enrolled with Touch ID." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:action_1];
            [alert addAction:action_2];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    }];
}

- (QLPreviewController *)previewCtrs{
    if (!_previewCtrs) {
        _previewCtrs = [[QLPreviewController alloc] init];
        _previewCtrs.delegate = self;
        _previewCtrs.dataSource = self;
        _previewCtrs.currentPreviewItemIndex = 2;
    }
    return _previewCtrs;
}

- (void)didFinishPreview{
    [self.previewCtrs dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didPreviewAction:(UIButton *)sender {
//    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    destPath = [destPath stringByAppendingPathComponent:@"preview.pdf"];
//    pdfURL = [NSURL fileURLWithPath:destPath];
//    if ([[NSFileManager  defaultManager] fileExistsAtPath:destPath]) {
////        [self presentViewController:self.previewCtrs animated:YES completion:nil];
//        UIDocumentInteractionController *preview = [UIDocumentInteractionController interactionControllerWithURL:pdfURL];
//        preview.delegate = self;
//        [preview presentOpenInMenuFromBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didFinishPreview)] animated:YES];
//        [preview presentOptionsMenuFromBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didFinishPreview)] animated:YES];
//        [preview presentPreviewAnimated:YES];
//    }else{
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//        NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"https://www.tutorialspoint.com/ios/ios_tutorial.pdf"]  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//            [[NSFileManager defaultManager] createFileAtPath:destPath contents:data attributes:nil];
//            [self presentViewController:self.previewCtrs animated:YES completion:nil];
//        }];
//        [task resume];
//    }
    PDFReaderViewController *ctrs = [[PDFReaderViewController alloc] initWithNibName:NSStringFromClass([PDFReaderViewController class]) bundle:nil];
    [self.navigationController pushViewController:ctrs animated:YES];
//    NSString *pathStr=[[NSBundle mainBundle]pathForResource:@"我的Bigfive分析报告，欢迎围观：.pdf" ofType:@"pdf"];
//    NSURL *fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",pathStr]];
    
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}


- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return pdfURL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
