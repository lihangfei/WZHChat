//
//  AKBaseWithBaseViewController.h
//  
//  Controller基类，
//      1. title栏统一样式及返回按钮默认处理事件
//      2. TabBar自动显示|隐藏处理，默认隐藏
//  Created by 吳梓杭 on 2017/6/28.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKBaseWithBaseViewControllerConfiguration <NSObject>

// 标题栏
- (NSString*)titleForRightButton;
- (UIImage*)imageForRightButton;
- (void)onRightButtonClicked:(id)sender;

// ImagePicker
- (void)onImagePickerViewHeightChanged:(CGFloat)height;

@end



@interface AKBaseWithBaseViewController : UIViewController<AKBaseWithBaseViewControllerConfiguration>

@property(nonatomic,strong)UILabel * lab_navigationItem;
@property (nonatomic, assign) BOOL shouldShowTabbar;    //是否显示顶部TabBar
@property(nonatomic,strong)UIButton * btn_return;

@end
