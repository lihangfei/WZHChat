//
//  WZHMoreView.h
//  chatWithEmotion
//
//  Created by 吳梓杭 on 2017/10/17.
//  Copyright © 2017年 刘全水. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZHMoreWayDelegate <NSObject>

///代理方法，点击表情按钮触发方法
-(void)MoreWayBtnDidClicked:(UIButton *)moreWayBtn;

@end

@interface WZHMoreView : UIImageView

@property(assign,nonatomic)id<WZHMoreWayDelegate>delegate;
@property(strong,nonatomic)UIButton * moreWayButton;

@end


