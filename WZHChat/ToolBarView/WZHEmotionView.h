//
//  WZHEmotionView.h
//  WZHChat
// 表情键盘
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZHTextAttachment.h"
#import "NSAttributedString+WZHEmojiExtension.h"

@protocol WZHEmotionViewdelegate <NSObject>

///发送，删除等按钮的代理事件，用tag值区按钮！
-(void)emotionView_sBtnDidClick:(UIButton *)btn;
///gif表情的代理事件！
-(void)gifBtnClick:(UIButton *)btn;

@end

@interface WZHEmotionView : UIImageView <UIScrollViewDelegate>

///textView，输入框
@property(nonatomic, strong)UITextView    *IputView;
///发送按钮
@property(strong, nonatomic)UIButton      *sendBtn;
///底部条的按钮
@property(strong,nonatomic)UIButton       *emojiBtn;

@property(assign,nonatomic) id <WZHEmotionViewdelegate> delegate;


@end
