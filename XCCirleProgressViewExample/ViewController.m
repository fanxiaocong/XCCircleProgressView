//
//  ViewController.m
//  XCCirleProgressViewExample
//
//  Created by 樊小聪 on 2017/3/9.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"

#import "Text.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Text *text = [[Text alloc] init];
    
    [self.navigationController pushViewController:text animated:YES];
}


@end
