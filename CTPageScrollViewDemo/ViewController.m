//
//  ViewController.m
//  CTPageScrollViewDemo
//
//  Created by changchentao on 16/6/6.
//  Copyright © 2016年 changchentao. All rights reserved.
//

#import "ViewController.h"
#import "CTPageScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CTPageScrollView *pageScrollView = [CTPageScrollView pageScrollView];
    pageScrollView.frame = CGRectMake(10, 20, 400, 300);
    pageScrollView.images = @[@"Targaryen.jpg",@"Lannister.jpg",@"Stark.jpg",@"Baratheon.jpg",@"Greyjoy.jpg"];
    [pageScrollView setPageControlOtherPageColor:[UIColor greenColor] currentPageCplor:[UIColor orangeColor]];
    pageScrollView.imageViewTapBlock = ^(NSInteger index){
        NSLog(@"%ld",(long)index);
    };
    [self.view addSubview:pageScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
