//
//  ViewController.m
//  GenTaiwanID
//
//  Created by diman on 2018/11/28.
//  Copyright © 2018 diman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[self genIdString] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

//身分證產生代碼，只會產生開頭A-H，原因...去看公式就知道了，我懶得補完
- (NSString *)genIdString {
    NSInteger two = arc4random() % 8 + 10;
    NSInteger gender = arc4random() % 2 + 1;
    NSInteger six = arc4random() % 900000 + 100000;
    NSString *IdString = [NSString stringWithFormat:@"%ld%ld%ld",two, gender, six];
    NSInteger total = 0;
    for (int i=0; i<IdString.length; i++) {
        const char *ch = [IdString UTF8String];
        NSInteger n = [[NSNumber numberWithChar:ch[i]] integerValue] - 48;
        if (i > 0) {
            total = total + n * (10-i);
        }
        else
            total = total + n;
    }
    NSInteger plus = total % 10;
    NSInteger ten = arc4random() % 10;
    NSInteger one = 10 - plus - ten;
    one = one >= 0 ? one : one + 10;
    
    char head = two + 55;
    
    IdString = [NSString stringWithFormat:@"%c%ld%ld%ld%ld",head, gender, six, ten, one];
    
    return IdString;
}


@end
