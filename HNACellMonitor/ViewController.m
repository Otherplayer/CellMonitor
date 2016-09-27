//
//  ViewController.m
//  HNACellMonitor
//
//  Created by __无邪_ on 16/9/27.
//  Copyright © 2016年 __无邪_. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnCellSignal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self refreshSignal:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh

- (IBAction)refreshSignal:(id)sender {
    NSString *title = [NSString stringWithFormat:@"%@ %@dBm",[self carrierName],@([self signalStreigth])];
    [self.btnCellSignal setTitle:title forState:UIControlStateNormal];
    [self.btnCellSignal.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.btnCellSignal setTitleColor:[self randomColor] forState:UIControlStateNormal];
}

#pragma mark - Getting carrier name and signal streigth

- (int)signalStreigth {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    int signalStrength = [[dataNetworkItemView valueForKey:@"signalStrengthRaw"] intValue];
    
    return signalStrength;
}

- (NSString *)carrierName {
    UIView* statusBar = [self statusBar];
    UIView* statusBarForegroundView = nil;
    for (UIView* view in statusBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIStatusBarForegroundView")]) {
            statusBarForegroundView = view;
            break;
        }
    }
    UIView* statusBarServiceItem = nil;
    for (UIView* view in statusBarForegroundView.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIStatusBarServiceItemView")]) {
            statusBarServiceItem = view;
            break;
        }
    }
    if (statusBarServiceItem) {
        id value = [statusBarServiceItem valueForKey:@"_serviceString"];
        
        if ([value isKindOfClass:[NSString class]]) {
            return (NSString *)value;
        }
    }
    return @"Unavailable";
}

- (UIView *)statusBar {
    NSString *statusBarString = [NSString stringWithFormat:@"%@ar", @"_statusB"];
    return [[UIApplication sharedApplication] valueForKey:statusBarString];
}


#pragma mark -Private

- (UIColor *)randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

@end
