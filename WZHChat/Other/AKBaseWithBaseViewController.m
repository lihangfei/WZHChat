
//
//  AKBaseWithBaseViewController.m
//  
//
//  Created by 吳梓杭 on 2017/6/28.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "AKBaseWithBaseViewController.h"


@interface AKBaseWithBaseViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView * navView;
@property(nonatomic,strong)UIView * titleView;
@end


@implementation AKBaseWithBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FFFFFF;
    self.navigationController.navigationBar.barTintColor = C339967;
    
    self.btn_return = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_return setImage:[UIImage imageNamed:@"icon_Returns"] forState:UIControlStateNormal];
    [_btn_return addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    _btn_return.frame = CGRectMake(0, 0, 10 * ScaleX_Num, 18 * ScaleY_Num);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btn_return];
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationItem.hidesBackButton = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onViewTapped:)];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
}
-(void)handleBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)onViewTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

@end


